import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
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
  List<bool> _visible = [false, false, false, false];
  List<LatLng> lastLocation = [
    LatLng(0.144455, 0.144455),
    LatLng(0.444155, 0.4444155),
    LatLng(0.444155, 0.444155),
    LatLng(0.444155, 0.444155)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'currentBoatPage';
    CurrentBoatBloc().setViewPosition = [true, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    BoatCardArguments arguments = ModalRoute.of(context).settings.arguments;
    CurrentBoatBloc().setCurrentBoat = arguments;
    Journey _journey = arguments.journey;
    BoatData _boat = arguments.boat;
    bool confirm = _boat.onJourney == 1;
    HistoricsProvider().getHistorics(journeyId: _journey.id);

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: gradientAppBar2(
          _journey.boatName, boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context).pop();
      }),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginExt),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Current status',
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
                              textOn: 'Arrived',
                              textOff: 'Confirm',
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
                                      'Are you sure you want to mark this boat with at ${DateTime.now().toString().substring(0, 16)} ?',
                                      'Departure Confirmation', () {
                                    //Navigator.of(context).pop();
                                    setOnJourney(_boat.id, context);
                                  }, () {
                                    Navigator.of(context).pushReplacementNamed(
                                        AuthBloc().routeValue,
                                        arguments:
                                            CurrentBoatBloc().currentBoatValue);
                                  });
                                } else if (_boat.onJourney == 1 &&
                                    state == false) {
                                  confirmationDialog(
                                      context,
                                      'Are you sure you want to mark this boat with at ${DateTime.now().toString().substring(0, 16)} ?',
                                      'Arrival Confirmation', () {
                                    //Navigator.of(context).pop();
                                    setOnJourney(_boat.id, context);
                                  }, () {
                                    Navigator.of(context).pop();
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
                            if (_boat.onJourney == 0) {
                              return arrivedIcon(25.0, blue1);
                            } else {
                              return Container();
                            }
                          }),
                          SizedBox(
                            height: 5.0,
                          ),
                          boatIconBlue(25.0, blue1),
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
                            if (_boat.onJourney == 0) {
                              return Text(
                                'Arrived',
                                style: TextStyle(
                                    color: blue1,
                                    fontWeight: FontWeight.w800,
                                    fontSize: messageTitle),
                              );
                            } else {
                              return Container();
                            }
                          }),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Departure:',
                            style: TextStyle(
                                color: blue1,
                                fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Current weight:',
                            style: TextStyle(
                                color: blue1,
                                fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Selling time:',
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
                          Text(
                            '',
                            style: TextStyle(
                                color: blue1,
                                //fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            _journey.ini.toString().substring(0, 16),
                            style: TextStyle(
                                color: blue1,
                                //fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            _journey.fWeight.toString() + ' KG',
                            style: TextStyle(
                                color: blue1,
                                //fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            (DateTime.now().difference(_journey.ini).inHours)
                                    .toString() +
                                ' HS',
                            style: TextStyle(
                                color: blue1,
                                //fontWeight: FontWeight.w800,
                                fontSize: messageTitle),
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
                          var _fourPositions = 0;
                          for (var i = _historics.historics.length - 1;
                              i >= 0;
                              i--) {
                            if (i == _historics.historics.length - 1) {
                              LatLng _latlong = latLongFromString(
                                  _historics.historics[i].bLocation);
                              lastLocation[_fourPositions] = _latlong;
                              _fourPositions++;
                            } else if (_historics.historics[i].tiP > 60) {
                              LatLng _latlong = latLongFromString(
                                  _historics.historics[i].bLocation);
                              lastLocation[_fourPositions] = _latlong;
                              _fourPositions++;
                            }
                            switch (_fourPositions) {
                              case 1:
                                _visible = [true, false, false, false];

                                break;
                              case 2:
                                _visible = [true, true, false, false];

                                break;
                              case 3:
                                _visible = [true, true, true, false];

                                break;
                              case 4:
                                _visible = [true, true, true, true];

                                break;
                              default:
                            }
                            if (_fourPositions > 3) {
                              break;
                            }
                          }
                        }
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: marginExt),
                            height: 291.0,
                            padding: EdgeInsets.all(0.0),
                            child: createFlutterMap(
                                context, _historics.historics[0].bLocation));
                      } else {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: marginExt),
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
                    StreamBuilder(
                        stream: CurrentBoatBloc().viewPosition,
                        builder: (context, AsyncSnapshot<List<bool>> snapshot) {
                          for (var i = 0; i < 4; i++) {
                            if (_visible[i] == false) {
                              lastLocation[i] =
                                  LatLng(0.1151545454, 0.1454545454);
                            }
                          }
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: marginExt),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: _visible[0],
                                  child: GestureDetector(
                                    onTap: () {
                                      CurrentBoatBloc().setViewPosition = [
                                        true,
                                        false,
                                        false,
                                        false
                                      ];
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Builder(builder: (context) {
                                          if (!snapshot.data[0]) {
                                            return statusIcon(20.0, 1);
                                          } else {
                                            return statusIcon(20.0, 3);
                                          }
                                        }),
                                        Container(
                                          width: 70.0,
                                          child: Text(
                                            '${lastLocation[0].latitude.toString().substring(0, 5)}:${lastLocation[0].longitude.toString().substring(0, 5)}',
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: blue1, fontSize: 10),
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
                                      CurrentBoatBloc().setViewPosition = [
                                        false,
                                        true,
                                        false,
                                        false
                                      ];
                                    },
                                    child: Column(
                                      children: [
                                        Builder(builder: (context) {
                                          if (!snapshot.data[1]) {
                                            return statusIcon(20.0, 1);
                                          } else {
                                            return statusIcon(20.0, 3);
                                          }
                                        }),
                                        Container(
                                          width: 50.0,
                                          child: Text(
                                            '${lastLocation[1].latitude.toString().substring(0, 5)}:${lastLocation[1].longitude.toString().substring(0, 5)}',
                                            style: TextStyle(color: blue1),
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
                                      CurrentBoatBloc().setViewPosition = [
                                        false,
                                        false,
                                        true,
                                        false
                                      ];
                                    },
                                    child: Column(
                                      children: [
                                        Builder(builder: (context) {
                                          if (!snapshot.data[2]) {
                                            return statusIcon(20.0, 1);
                                          } else {
                                            return statusIcon(20.0, 3);
                                          }
                                        }),
                                        Container(
                                          width: 50.0,
                                          child: Text(
                                            '${lastLocation[2].latitude.toString()}:${lastLocation[2].longitude.toString()}',
                                            style: TextStyle(color: blue1),
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
                                      CurrentBoatBloc().setViewPosition = [
                                        false,
                                        false,
                                        false,
                                        true
                                      ];
                                    },
                                    child: Column(
                                      children: [
                                        Builder(builder: (context) {
                                          if (!snapshot.data[3]) {
                                            return statusIcon(20.0, 1);
                                          } else {
                                            return statusIcon(20.0, 3);
                                          }
                                        }),
                                        Container(
                                          width: 50.0,
                                          child: Text(
                                            '${lastLocation[3].latitude.toString()}:${lastLocation[3].longitude.toString()}',
                                            style: TextStyle(color: blue1),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
                StreamBuilder(
                  stream: AlertsBloc().alert,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => onAfterBuild(_scaffoldKey.currentContext));
                    return Container();
                  },
                ),
              ],
            )),
          ],
        ),
      ),
      bottomNavigationBar: botomBar(0, context),
    ));
  }
}

Widget _boatCard(BuildContext context, Journey journey, String boatName) {
  return Container(
    height: 150,
    margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
    // decoration: BoxDecoration(
    //     border: Border.all(color: blue1, style: BorderStyle.solid, width: 2.0),
    //     borderRadius: BorderRadius.circular(5.0)),
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: marginInt, vertical: marginSupBoatCard),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    boatName,
                    style: TextStyle(
                        color: blue1,
                        fontWeight: FontWeight.bold,
                        fontSize: messageTitle),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text(
                    'Departure:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('04/05/2021 12:38',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Arrival:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('05/05/2021 12:38',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'final Weight:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('100Kg',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: marginInt, top: marginSupBoatCard),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  statusIcon(20.0, 1),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Status:',
                    style: TextStyle(
                        color: blue1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Arrived',
                    style: TextStyle(
                        color: blue1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  arrivedIcon(20.0, blue1)
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
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

  AlertsBloc().setAlert = Alerts('Updating', "Updating");
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
