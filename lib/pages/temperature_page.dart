import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';

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

import '../styles/colors.dart';

class TemperaturePage extends StatefulWidget {
  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'temperaturePage';
  }

  @override
  Widget build(BuildContext context) {
    Journey _temperature = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          _temperature.boatName, boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context)
            .pushReplacementNamed('journeyPage', arguments: _temperature);
      }),
      body: SingleChildScrollView(
        child: Container(
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
                                'TRAVEL ${_temperature.id}',
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
                          'TEMPERATURE',
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
                            Text(
                              'Desire temperature: ${_temperature.id} º',
                              style: TextStyle(
                                  color: blue1,
                                  fontSize: titleBarSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Average temperature: ${_temperature.id} º',
                              style: TextStyle(
                                  color: blue1,
                                  fontSize: titleBarSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Temperature',
                              style: TextStyle(
                                  color: gray,
                                  fontSize: titleBarSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                            child:
                                LineChartTemp(HistoricsBloc().historicsValue)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Hours',
                              style: TextStyle(
                                  color: gray,
                                  fontSize: titleBarSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
  }
}

class Temperature {}

Widget temperatureCard(
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
