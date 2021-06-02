import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';

import 'package:boat_monitor/charts/line_chart.dart';
import 'package:boat_monitor/charts/line_chart_temp.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';

import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import '../styles/colors.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  String _position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'locationPage';
  }

  @override
  Widget build(BuildContext context) {
    Journey _location = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          _location.boatName, boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context)
            .pushReplacementNamed('journeyPage', arguments: _location);
      }),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: marginExt1),
        height: MediaQuery.of(context).size.height,
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
                        // margin: EdgeInsets.symmetric(horizontal: marginExt1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Container()),
                            Text(
                              'TRAVEL ${_location.id}',
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
                        'LOCATION',
                        style: TextStyle(
                          color: blue1,
                          fontSize: correoSize,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
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
                                'Departure:',
                                style: TextStyle(
                                    color: blue1,
                                    fontSize: titleBarSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Arrival:',
                                style: TextStyle(
                                    color: blue1,
                                    fontSize: titleBarSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Duration:',
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
                                '12:00AM 10/12/2021',
                                style: TextStyle(
                                  color: blue1,
                                  fontSize: titleBarSize,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '12:00AM 11/12/2021',
                                style: TextStyle(
                                  color: blue1,
                                  fontSize: titleBarSize,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '24 HS',
                                style: TextStyle(
                                  color: blue1,
                                  fontSize: titleBarSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          //margin: EdgeInsets.symmetric(horizontal: marginExt),
                          height: 291.0,
                          padding: EdgeInsets.all(0.0),
                          child: createFlutterMap(context,_position)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        children: [
                          Container(
                            // margin:
                            //     EdgeInsets.symmetric(horizontal: marginExt),
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
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: marginExt),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    statusIcon(20.0, 1),
                                    Container(
                                      width: 50.0,
                                      child: Text(
                                        '33.809:-117.91',
                                        style: TextStyle(color: blue1),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    statusIcon(20.0, 3),
                                    Container(
                                      width: 50.0,
                                      child: Text(
                                        '33.809:-117.91',
                                        style: TextStyle(color: blue1),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    statusIcon(20.0, 1),
                                    Container(
                                      width: 50.0,
                                      child: Text(
                                        '33.809:-117.91',
                                        style: TextStyle(color: blue1),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    statusIcon(20.0, 1),
                                    Container(
                                      width: 50.0,
                                      child: Text(
                                        '33.809:-117.91',
                                        style: TextStyle(color: blue1),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
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
