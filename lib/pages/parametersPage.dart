import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ParametersPage extends StatefulWidget {
  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('managerPage');
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar2(TextLanguage.of(context).parameters,
            parametersIcon(25.0, Colors.white), () {
          Navigator.of(context).pushReplacementNamed('managerPage');
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
                  _parametersHeader(context),
                  _parametersItem(
                      context, {"name": 'weight', "value": 50, "default": 35},
                      () {
                    parametersDialog(context, 'weight', () {
                      Navigator.of(context).pop();
                      confirmationDialog(
                          context,
                          'Are you sure you want to mark weight',
                          'Setpoint Confirmation', () {
                        print('yess');
                      }, () {
                        print('no');
                        Navigator.of(context).pop();
                      });
                    });
                    print('weight');
                  }),
                  _parametersItem(context,
                      {"name": 'temperature', "value": 25, "default": 20}, () {
                    print('temp');
                  }),
                  _parametersItem(context,
                      {"name": 'unavailable', "value": 6, "default": 7}, () {
                    print('time');
                  })
                ],
              )),
              // StreamBuilder(
              //   stream: PendingParameterssBloc().pendingParameterss,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return Container();
              //   },
              // ),
            ],
          ),
        ),
        bottomNavigationBar: botomBar(1, context),
      )),
    );
  }
}

Widget _parametersItem(BuildContext context, parameters, Function onTap()) {
  return Container(
    margin: EdgeInsets.only(left: marginExt1, right: marginExt1),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 70) / 3,
                          child: Text(
                            parameters["name"],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          )),
                      Container(
                          width: (MediaQuery.of(context).size.width - 70) / 3,
                          child: Text(parameters["default"].toString(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip)),
                      Container(
                          width: (MediaQuery.of(context).size.width - 70) / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(parameters["value"].toString(),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                child: editIcon(18.0, blue1),
                                onTap: () {
                                  onTap();
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          //margin: EdgeInsets.symmetric(horizontal: marginExt),
          child: Divider(
            color: gray1,
            height: 1.0,
            thickness: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _parametersHeader(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: marginExt1, right: marginExt1),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 180) / 3,
                          child: Text(
                            'Parameter',
                            style: TextStyle(
                                color: blue1, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                          width: (MediaQuery.of(context).size.width - 220) / 3,
                          child: Text("Default",
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip)),
                      Container(
                          width: (MediaQuery.of(context).size.width - 125) / 3,
                          child: Text("Value",
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          //margin: EdgeInsets.only(left: marginExt1 * 2),
          child: Divider(
            color: blue1,
            height: 1.0,
            thickness: 1.0,
          ),
        ),
      ],
    ),
  );
}

/*
parametersDialog(context, 'hola',(){confirmationDialog(context, 'confirm', 'setpoint', () {
                  print('yes');
                }, () {
                  print('no');
                });})
*/
