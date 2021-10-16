import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/Argument_bloc.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/currenBoatBloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/historics_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/providers/historics_provider.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/providers/mqtt_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/customSwitch.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:slider_button/slider_button.dart';

class CurrentBoatPage extends StatefulWidget {
  @override
  _CurrentBoatPageState createState() => _CurrentBoatPageState();
}

class _CurrentBoatPageState extends State<CurrentBoatPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  LatLng _position;
  MapController controller = MapController();
  MQTTClientWrapper mqtt;
  String currentWeight = '0.0';
  List<bool> _visible = [false, false, false, false];
  List<LatLng> lastLocation = [
    LatLng(0, 0),
    LatLng(0, 0),
    LatLng(0, 0),
    LatLng(0, 0)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'currentBoatPage';
    CurrentBoatBloc().setViewPosition = [true, false, false, false];
    CurrentBoatBloc().setVisibility = _visible;
    mqtt = MQTTClientWrapper(() {}, (hola, hello) {});
    mqtt.prepareMqttClient();
  }

  @override
  Widget build(BuildContext context) {
    BoatCardArguments arguments = ModalRoute.of(context).settings.arguments;
    CurrentBoatBloc().setCurrentBoat = arguments;
    Journey _journey = arguments.journey;
    BoatData _boat = arguments.boat;
    bool confirm = _boat.onJourney == 1;
    HistoricsProvider().getHistorics(context, journeyId: [_journey.id]);
    double _extraHeight = 0;
    double _minusSize = 0;
    double _extraSizeBox = 0;
    String sailingTime = '';
    int diferenceInMinutes;
    int diferenceInHours;
    if (_journey.ed != null && _journey.ed != _journey.ini) {
      diferenceInMinutes = _journey.ed.difference(_journey.ini).inMinutes;
    } else {
      diferenceInMinutes = DateTime.now().difference(_journey.ini).inMinutes;
    }
    print('minutos:$diferenceInMinutes}');
    diferenceInHours = diferenceInHours = diferenceInMinutes ~/ 60;
    diferenceInMinutes = diferenceInMinutes % 60;

    print('minutos:$diferenceInMinutes}');
    print('Horas:$diferenceInHours}');
    sailingTime = diferenceInHours > 0
        ? '$diferenceInHours HS ${diferenceInMinutes > 0 ? '$diferenceInMinutes MIN' : ''}'
        : '$diferenceInMinutes MIN';

    if (MediaQuery.of(context).size.height < 750) {
      _extraHeight = 50.0;
    }
    if (MediaQuery.of(context).size.width < 770) {
      _minusSize = 3.0;
      _extraSizeBox = 2.0;
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('homePage');
      },
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: gradientAppBar2(
            _journey.boatName, boatIconBlue(25.0, Colors.white), () {
          Navigator.of(context).pushReplacementNamed('homePage');
        }),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + _extraHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: marginExt),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            TextLanguage.of(context).currentStatus,
                            style: TextStyle(
                                color: blue1,
                                fontWeight: FontWeight.w800,
                                fontSize: statusSize),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    StreamBuilder<Object>(
                        stream: CurrentBoatBloc().viewPosition,
                        builder: (context, snapshot) {
                          print(_boat.onJourney);
                          print(confirm.toString() + 'valor');
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: marginExt),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                LiteRollingSwitch(
                                  //initial value
                                  value: confirm,
                                  textOn: TextLanguage.of(context).arrived,
                                  textOff: TextLanguage.of(context).confirm,
                                  colorOn: gray,
                                  colorOff: gray,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  textSize: 12.0,

                                  onChanged: (bool state) {
                                    //Use it to manage the different states
                                    print('Current State of SWITCH IS: $state');
                                    if (_boat.onJourney == 0 && state == true) {
                                      confirmationDialog(
                                          context,
                                          TextLanguage.of(context)
                                                  .departureMessageConfirmation +
                                              ' ${DateTime.now().toString().substring(0, 16)} ?',
                                          TextLanguage.of(context)
                                              .departureConfirmation, () {
                                        Navigator.of(context).pop();
                                        //setOnJourney(_boat.id, context);
                                        AlertsBloc().setAlert = Alerts(
                                            TextLanguage.of(context).updating,
                                            "Updating");
                                        mqtt.journeyStart(_boat.id);
                                        return;
                                      }, () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AuthBloc().routeValue,
                                                arguments: CurrentBoatBloc()
                                                    .currentBoatValue);
                                        return;
                                      });
                                    } else if (_boat.onJourney == 1 &&
                                        state == false) {
                                      confirmationDialog(
                                          context,
                                          TextLanguage.of(context)
                                                  .departureMessageConfirmation +
                                              ' ${DateTime.now().toString().substring(0, 16)} ?',
                                          TextLanguage.of(context)
                                              .arrivalConfirmation, () {
                                        Navigator.of(context).pop();
                                        //setOnJourney(_boat.id, context);
                                        AlertsBloc().setAlert = Alerts(
                                            TextLanguage.of(context).updating,
                                            "Updating");
                                        mqtt.journeyStop(_boat.id);
                                      }, () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AuthBloc().routeValue,
                                                arguments: CurrentBoatBloc()
                                                    .currentBoatValue);
                                        return;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: marginExt),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Builder(builder: (context) {
                                if (_boat.onJourney == 0 && _boat.lj != null) {
                                  return arrivedIcon(25.0, blue1);
                                } else {
                                  return Container(
                                    height: 25.0,
                                    width: 25.0,
                                  );
                                }
                              }),
                              SizedBox(
                                height: 5.0,
                              ),
                              Builder(builder: (context) {
                                if (_boat.lj != null) {
                                  return boatIconBlue(25.0, blue1);
                                } else {
                                  return Container(
                                    height: 25.0,
                                    width: 25.0,
                                  );
                                }
                              }),
                              SizedBox(
                                height: 5.0,
                              ),
                              weightIcon(35.0, blue1),
                              SizedBox(
                                height: 5.0,
                              ),
                              clockIcon(25.0, blue1)
                            ],
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Builder(builder: (context) {
                                if (_boat.onJourney == 0 && _boat.lj != null) {
                                  return Text(
                                    TextLanguage.of(context).arrived + ':',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                } else {
                                  return Text(
                                    '    ',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                }
                              }),
                              SizedBox(
                                height: 10.0,
                              ),
                              Builder(builder: (context) {
                                if (_boat.lj != null) {
                                  return Text(
                                    TextLanguage.of(context).departure + ':',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                } else {
                                  return Text(
                                    '    ',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                }
                              }),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                TextLanguage.of(context).currentWeight + ':',
                                style: TextStyle(
                                    color: blue1,
                                    fontWeight: FontWeight.w800,
                                    fontSize: messageTitle),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                TextLanguage.of(context).sailingTime + ':',
                                style: TextStyle(
                                    color: blue1,
                                    fontWeight: FontWeight.w800,
                                    fontSize: messageTitle),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Builder(builder: (context) {
                                if (_boat.lj != null && _boat.onJourney == 0) {
                                  return Text(
                                    _journey.ed.toString().substring(0, 16),
                                    style: TextStyle(
                                        color: blue1,
                                        //fontWeight: FontWeight.w800,
                                        fontSize: messageTitle - _minusSize),
                                  );
                                } else {
                                  return Text(
                                    '    ',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                }
                              }),
                              SizedBox(
                                height: 10.0 + _extraSizeBox,
                              ),
                              Builder(builder: (context) {
                                if (_boat.lj != null) {
                                  return Text(
                                    _journey.ini.toString().substring(0, 16),
                                    style: TextStyle(
                                        color: blue1,
                                        //fontWeight: FontWeight.w800,
                                        fontSize: messageTitle - _minusSize),
                                  );
                                } else {
                                  return Text(
                                    '    ',
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: messageTitle),
                                  );
                                }
                              }),
                              SizedBox(
                                height: 10.0 + _extraSizeBox,
                              ),
                              StreamBuilder(
                                stream: HistoricsBloc().historics,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Container(
                                    child: Text(
                                      currentWeight + ' KG',
                                      style: TextStyle(
                                          color: blue1,
                                          //fontWeight: FontWeight.w800,
                                          fontSize: messageTitle - _minusSize),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10.0 + _extraSizeBox,
                              ),
                              Text(
                                sailingTime,
                                style: TextStyle(
                                    color: blue1,
                                    //fontWeight: FontWeight.w800,
                                    fontSize: messageTitle - _minusSize),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    StreamBuilder(
                        stream: HistoricsBloc().historics,
                        builder: (context, AsyncSnapshot<Historics> snapshot) {
                          if (snapshot.hasData) {
                            Historics _historics = snapshot.data;

                            if (_historics.historics.length > 0) {
                              currentWeight =
                                  '${_historics.historics.last.contWeight}';
                              var _fourPositions = 0;
                              for (var i = _historics.historics.length - 1;
                                  i >= 0;
                                  i--) {
                                if (i == _historics.historics.length - 1) {
                                  LatLng _latlong = latLongFromString(
                                      _historics.historics[i].bLocation);
                                  if (_latlong != null) {
                                    lastLocation[_fourPositions] = _latlong;
                                  }
                                  _fourPositions++;
                                } else if (_historics.historics[i].tiP > 49) {
                                  LatLng _latlong = latLongFromString(
                                      _historics.historics[i].bLocation);
                                  lastLocation[_fourPositions] = _latlong;
                                  _fourPositions++;
                                }
                                switch (_fourPositions) {
                                  case 1:
                                    _visible = [true, false, false, false];
                                    CurrentBoatBloc().setVisibility = _visible;
                                    break;
                                  case 2:
                                    _visible = [true, true, false, false];
                                    CurrentBoatBloc().setVisibility = _visible;
                                    break;
                                  case 3:
                                    _visible = [true, true, true, false];
                                    CurrentBoatBloc().setVisibility = _visible;
                                    break;
                                  case 4:
                                    _visible = [true, true, true, true];
                                    CurrentBoatBloc().setVisibility = _visible;
                                    break;
                                  default:
                                }

                                if (_fourPositions > 3) {
                                  break;
                                }
                              }
                            }
                            return StreamBuilder(
                                stream: CurrentBoatBloc().viewPosition,
                                builder: (context,
                                    AsyncSnapshot<List<bool>> snapshot) {
                                  LatLng _currenMapView;
                                  if (snapshot.hasData) {
                                    for (var i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      print(
                                          '${snapshot.data.length}snapshot.data.length');
                                      if (snapshot.data[i]) {
                                        _currenMapView = lastLocation[i];
                                        if (_currenMapView == LatLng(0, 0)) {
                                          _visible = [
                                            false,
                                            false,
                                            false,
                                            false
                                          ];
                                          CurrentBoatBloc().setVisibility =
                                              _visible;
                                        }
                                      }
                                    }
                                    return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: marginExt),
                                        height: 291.0,
                                        padding: EdgeInsets.all(0.0),
                                        child: createFlutterMap(
                                            context,
                                            _currenMapView,
                                            controller,
                                            _historics,
                                            true));
                                  } else {
                                    return Center(
                                      child: circularProgressCustom(),
                                    );
                                  }
                                });
                          } else {
                            return Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: marginExt),
                                height: 291.0,
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(blue1),
                                  ),
                                ));
                          }
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: marginExt),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2.0,
                              ),
                              Divider(
                                color: blue1,
                                thickness: 2.0,
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<Object>(
                            stream: CurrentBoatBloc().visibility,
                            builder: (context, snapshot) {
                              return Container(
                                child: StreamBuilder(
                                    stream: CurrentBoatBloc().viewPosition,
                                    builder: (context,
                                        AsyncSnapshot<List<bool>> snapshot) {
                                      print(
                                          '${lastLocation.length}lastlocationlength');
                                      print(_visible);
                                      for (var i = 0;
                                          i < lastLocation.length;
                                          i++) {
                                        print('${i}for index');
                                        if (_visible[i] == false) {
                                          lastLocation[i] = LatLng(0, 0);
                                        }
                                      }

                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: marginExt),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Visibility(
                                              visible: _visible[0],
                                              child: GestureDetector(
                                                onTap: () {
                                                  CurrentBoatBloc()
                                                      .setViewPosition = [
                                                    true,
                                                    false,
                                                    false,
                                                    false
                                                  ];
                                                  controller.move(
                                                      lastLocation[0],
                                                      controller.zoom);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Builder(builder: (context) {
                                                      if (!snapshot.data[0]) {
                                                        return statusIcon(
                                                            20.0, 1);
                                                      } else {
                                                        return statusIcon(
                                                            20.0, 3);
                                                      }
                                                    }),
                                                    Container(
                                                      width: 70.0,
                                                      child: Text(
                                                        '${lastLocation[0].latitude.toString().length > 5 ? lastLocation[0].latitude.toString().substring(0, 5) : lastLocation[0].latitude.toString()}:${lastLocation[0].longitude.toString().length > 5 ? lastLocation[0].longitude.toString().substring(0, 5) : lastLocation[0].longitude.toString()}',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: _visible[1],
                                              child: GestureDetector(
                                                onTap: () {
                                                  CurrentBoatBloc()
                                                      .setViewPosition = [
                                                    false,
                                                    true,
                                                    false,
                                                    false
                                                  ];
                                                  controller.move(
                                                      lastLocation[1],
                                                      controller.zoom);
                                                },
                                                child: Column(
                                                  children: [
                                                    Builder(builder: (context) {
                                                      if (!snapshot.data[1]) {
                                                        return statusIcon(
                                                            20.0, 1);
                                                      } else {
                                                        return statusIcon(
                                                            20.0, 3);
                                                      }
                                                    }),
                                                    Container(
                                                      width: 70.0,
                                                      child: Text(
                                                        '${lastLocation[1].latitude.toString().length > 5 ? lastLocation[1].latitude.toString().substring(0, 5) : lastLocation[1].latitude.toString()}:${lastLocation[1].longitude.toString().length > 5 ? lastLocation[1].longitude.toString().substring(0, 5) : lastLocation[1].longitude.toString()}',
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: _visible[2],
                                              child: GestureDetector(
                                                onTap: () {
                                                  CurrentBoatBloc()
                                                      .setViewPosition = [
                                                    false,
                                                    false,
                                                    true,
                                                    false
                                                  ];
                                                  controller.move(
                                                      lastLocation[2],
                                                      controller.zoom);
                                                },
                                                child: Column(
                                                  children: [
                                                    Builder(builder: (context) {
                                                      if (!snapshot.data[2]) {
                                                        return statusIcon(
                                                            20.0, 1);
                                                      } else {
                                                        return statusIcon(
                                                            20.0, 3);
                                                      }
                                                    }),
                                                    Container(
                                                      width: 70.0,
                                                      child: Text(
                                                        '${lastLocation[2].latitude.toString().length > 5 ? lastLocation[2].latitude.toString().substring(0, 5) : lastLocation[2].latitude.toString()}:${lastLocation[2].longitude.toString().length > 5 ? lastLocation[2].longitude.toString().substring(0, 5) : lastLocation[2].longitude.toString()}',
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: _visible[3],
                                              child: GestureDetector(
                                                onTap: () {
                                                  CurrentBoatBloc()
                                                      .setViewPosition = [
                                                    false,
                                                    false,
                                                    false,
                                                    true
                                                  ];
                                                  controller.move(
                                                      lastLocation[3],
                                                      controller.zoom);
                                                },
                                                child: Column(
                                                  children: [
                                                    Builder(builder: (context) {
                                                      if (!snapshot.data[3]) {
                                                        return statusIcon(
                                                            20.0, 1);
                                                      } else {
                                                        return statusIcon(
                                                            20.0, 3);
                                                      }
                                                    }),
                                                    Container(
                                                      width: 70.0,
                                                      child: Text(
                                                        '${lastLocation[3].latitude.toString().length > 5 ? lastLocation[3].latitude.toString().substring(0, 5) : lastLocation[3].latitude.toString()}:${lastLocation[3].longitude.toString().length > 5 ? lastLocation[3].longitude.toString().substring(0, 5) : lastLocation[3].longitude.toString()}',
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            })
                      ],
                    ),
                    StreamBuilder(
                      stream: AlertsBloc().alert,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        ArgumentBloc().setArgument = arguments;
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => onAfterBuild(_scaffoldKey.currentContext));
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(0, context),
      )),
    );
  }
}

createMap() {
  return TileLayerOptions(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c']);
}

// createMarker() {
//   return MarkerLayerOptions(
//     markers: [
//       new Marker(
//         width: 80.0,
//         height: 80.0,
//         point: new LatLng(51.5, -0.09),
//         builder: (ctx) => new Container(
//           child: new FlutterLogo(),
//         ),
//       ),
//     ],
//   );
// }

void setOnJourney(int boatId, BuildContext context) async {
  print(boatId);

  AlertsBloc().setAlert = Alerts(TextLanguage.of(context).updating, "Updating");
  //updating(context, TextLanguage.of(context).loginButtonText);
  var _set = {'ok': true, 'message': 'On Journey'};
  print(_set);
  if (_set["ok"] == true) {
    // Navigator.of(context).pop();
    print(_set["message"]);
    AlertsBloc().setAlert = Alerts(_set["message"], "Updated");

    //
  } else {
    print(_set["message"]);
    AlertsBloc().setAlert = Alerts(_set["message"], "Error");
  }
}
