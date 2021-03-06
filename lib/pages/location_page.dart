import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/argument_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/currenBoatBloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/historics_model.dart';
import 'package:boat_monitor/models/journney_model.dart';

import 'package:boat_monitor/providers/historics_provider.dart';

import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import '../styles/colors.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  LatLng _position;
  MapController controller = MapController();
  List<bool> _visible = [false, false, false, false];
  List<LatLng> lastLocation = [
    LatLng(0, 0),
    LatLng(0, 0),
    LatLng(0, 0),
    LatLng(0, 0)
  ];
  @override
  void initState() {
    CurrentBoatBloc().setViewPosition = [true, false, false, false];
    CurrentBoatBloc().setVisibility = _visible;

    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'locationPage';
  }

  @override
  Widget build(BuildContext context) {
    JourneyCardArgument _location = ModalRoute.of(context).settings.arguments;
    print(_location.journey);
    HistoricsBloc().setHistorics = _location.historics;
    double _extraHeight = 0;
    String sailingTime = '';
    int diferenceInMinutes;
    int diferenceInHours;
    if (_location.journey.ed != null &&
        _location.journey.ed != _location.journey.ini) {
      diferenceInMinutes =
          _location.journey.ed.difference(_location.journey.ini).inMinutes;
    } else {
      diferenceInMinutes =
          DateTime.now().difference(_location.journey.ini).inMinutes;
    }
    print('minutos:$diferenceInMinutes}');
    diferenceInHours = diferenceInHours = diferenceInMinutes ~/ 60;
    diferenceInMinutes = diferenceInMinutes % 60;

    print('minutos:$diferenceInMinutes}');
    print('Horas:$diferenceInHours}');
    sailingTime = diferenceInHours > 0
        ? '$diferenceInHours HS ${diferenceInMinutes > 0 ? '$diferenceInMinutes MIN' : ''}'
        : '$diferenceInMinutes MIN';
    if (MediaQuery.of(context).size.height < 2000) {
      _extraHeight = 50.0;
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            .pushReplacementNamed('journeyPage', arguments: _location);
      },
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: gradientAppBar2(
            _location.journey.boatName, boatIconBlue(25.0, Colors.white), () {
          Navigator.of(context)
              .pushReplacementNamed('journeyPage', arguments: _location);
        }),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + _extraHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: marginExt1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: Container()),
                                Text(
                                  TextLanguage.of(context)
                                          .travel
                                          .toUpperCase() +
                                      ' ${_location.journey.id}',
                                  style: TextStyle(
                                      color: blue1,
                                      fontSize: statusSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        AlertsBloc().setAlert = Alerts(
                                            TextLanguage.of(context)
                                                .downloading,
                                            "Updating");
                                        final _resp = await HistoricsProvider()
                                            .getHistorics(context,
                                                journeyId: [
                                                  _location.journey.id
                                                ],
                                                download: true);
                                        if (_resp['ok']) {
                                          AlertsBloc().setAlert = Alerts(
                                              _resp['message'], 'Updated');
                                        } else {
                                          AlertsBloc().setAlert =
                                              Alerts(_resp['message'], 'Error');
                                        }
                                      },
                                      child: Container(
                                        child: downloadIcon(40.0, blue1),
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            TextLanguage.of(context).location.toUpperCase(),
                            style: TextStyle(
                              color: blue1,
                              fontSize: correoSize,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: marginExt1),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    boatIconBlue(20.0, blue1),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    arrivedIcon(20.0, blue1),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    durationIcon(20.0, blue1),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      TextLanguage.of(context).departure + ':',
                                      style: TextStyle(
                                          color: blue1,
                                          fontSize: titleBarSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      TextLanguage.of(context).arrival + ':',
                                      style: TextStyle(
                                          color: blue1,
                                          fontSize: titleBarSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      TextLanguage.of(context).duration + ':',
                                      style: TextStyle(
                                          color: blue1,
                                          fontSize: titleBarSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 10.0,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _location.journey.ini
                                          .toString()
                                          .substring(0, 16),
                                      style: TextStyle(
                                        color: blue1,
                                        fontSize: titleBarSize,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      _location.journey.ed ==
                                              _location.journey.ini
                                          ? '-'
                                          : _location.journey.ed
                                              .toString()
                                              .substring(0, 16),
                                      style: TextStyle(
                                        color: blue1,
                                        fontSize: titleBarSize,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      sailingTime,
                                      style: TextStyle(
                                        color: blue1,
                                        fontSize: titleBarSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          StreamBuilder(
                              stream: HistoricsBloc().historics,
                              builder:
                                  (context, AsyncSnapshot<Historics> snapshot) {
                                if (snapshot.hasData) {
                                  Historics _historics = snapshot.data;
                                  if (_historics.historics.length > 0) {
                                    var _fourPositions = 0;
                                    for (var i =
                                            _historics.historics.length - 1;
                                        i >= 0;
                                        i--) {
                                      if (i ==
                                          _historics.historics.length - 1) {
                                        LatLng _latlong = latLongFromString(
                                            _historics.historics[i].bLocation);
                                        if (_latlong != null) {
                                          lastLocation[_fourPositions] =
                                              _latlong;
                                        }

                                        _fourPositions++;
                                      } else if (_historics.historics[i].tiP >
                                          49) {
                                        LatLng _latlong = latLongFromString(
                                            _historics.historics[i].bLocation);
                                        lastLocation[_fourPositions] = _latlong;
                                        _fourPositions++;
                                      }
                                      switch (_fourPositions) {
                                        case 1:
                                          _visible = [
                                            true,
                                            false,
                                            false,
                                            false
                                          ];
                                          CurrentBoatBloc().setVisibility =
                                              _visible;
                                          break;
                                        case 2:
                                          _visible = [true, true, false, false];
                                          CurrentBoatBloc().setVisibility =
                                              _visible;
                                          break;
                                        case 3:
                                          _visible = [true, true, true, false];
                                          CurrentBoatBloc().setVisibility =
                                              _visible;
                                          break;
                                        case 4:
                                          _visible = [true, true, true, true];
                                          CurrentBoatBloc().setVisibility =
                                              _visible;
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
                                            if (snapshot.data[i]) {
                                              _currenMapView = lastLocation[i];
                                              if (_currenMapView ==
                                                  LatLng(0, 0)) {
                                                _visible = [
                                                  false,
                                                  false,
                                                  false,
                                                  false
                                                ];
                                                CurrentBoatBloc()
                                                    .setVisibility = _visible;
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
                                          return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: marginExt),
                                              height: 291.0,
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 50.0,
                                                width: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          blue1),
                                                ),
                                              ));
                                        }
                                      });
                                } else {
                                  return Center(
                                    child: circularProgressCustom(),
                                  );
                                }
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: marginExt),
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
                                          stream:
                                              CurrentBoatBloc().viewPosition,
                                          builder: (context,
                                              AsyncSnapshot<List<bool>>
                                                  snapshot) {
                                            for (var i = 0; i < 4; i++) {
                                              if (_visible[i] == false) {
                                                lastLocation[i] = LatLng(0, 0);
                                              }
                                            }
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: marginExt),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Builder(builder:
                                                              (context) {
                                                            if (!snapshot
                                                                .data[0]) {
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
                                                                  TextOverflow
                                                                      .clip,
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
                                                          Builder(builder:
                                                              (context) {
                                                            if (!snapshot
                                                                .data[1]) {
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
                                                          Builder(builder:
                                                              (context) {
                                                            if (!snapshot
                                                                .data[2]) {
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
                                                          Builder(builder:
                                                              (context) {
                                                            if (!snapshot
                                                                .data[3]) {
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
                        ],
                      ),
                    ),
                  ],
                )),
                StreamBuilder(
                  stream: AlertsBloc().alert,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    ArgumentBloc().setArgument = JourneyCardArgument(
                        journey: _location.journey,
                        historics: HistoricsBloc().historicsValue);
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => onAfterBuild(
                              _scaffoldKey.currentContext,
                            ));
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(1, context),
      )),
    );
  }
}

class Location {}

Widget locationCard(
    BuildContext context, Widget icon, String text, Widget child) {
  return Stack(
    children: [
      Container(
        //margin: EdgeInsets.symmetric(horizontal: marginExt1),
        height: 135.0,
        width: MediaQuery.of(context).size.width,
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage('assets/cardBorderShadow.png'),
        ),
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: marginExt1),
          height: 135.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(text, style: TextStyle(color: blue1, fontSize: 20.0))
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        //color: blue,
                        height: 110,
                        width: MediaQuery.of(context).size.width -
                            (2 * marginExt1) -
                            160,
                        child: Center(child: child)),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          )),
    ],
  );
}
