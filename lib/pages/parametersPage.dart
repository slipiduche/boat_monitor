import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/parameters_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/providers/parameters_provider.dart';
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
    ParametersProvider().getParameters(context);
    AuthBloc().setRoute = 'parametersPage';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_prefs.userType > 1) {
          Navigator.of(context).pushReplacementNamed('managerPage');
        } else {
          Navigator.of(context).pushReplacementNamed('supervisorPage');
        }
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar2(TextLanguage.of(context).parameters,
            parametersIcon(25.0, Colors.white), () {
          if (_prefs.userType > 1) {
            Navigator.of(context).pushReplacementNamed('managerPage');
          } else {
            Navigator.of(context).pushReplacementNamed('supervisorPage');
          }
        }),
        body: StreamBuilder<Object>(
            stream: ParametersBloc().parameters,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
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
                          _parametersItem(context, {
                            "name":
                                TextLanguage.of(context).weight.toLowerCase(),
                            "value": 50,
                            "default": 35.0
                            // ignore: missing_return
                          }, () {
                            parametersDialog(
                                context, TextLanguage.of(context).weight, () {
                              Navigator.of(context).pop();
                              confirmationDialog(
                                  context,
                                  TextLanguage.of(context)
                                      .changeWeightConfirmation,
                                  // ignore: missing_return
                                  TextLanguage.of(context).setPointConfirmation,
                                  () {
                                AlertsBloc().setAlertClosed = false;
                                print('yess');
                                AlertsBloc().setAlert = Alerts(
                                    TextLanguage.of(context).updating,
                                    "Updating");
                                ParametersProvider().setParameters(
                                    context,
                                    ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .id,
                                    weight: double.parse(
                                        ParametersBloc().parametersFieldValue),
                                    temperature: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .dtemp,
                                    timeout: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .timeOut);
                              }, () {
                                print('no');
                                Navigator.of(context).pop();
                              });
                            });
                            print('weight');
                          }),
                          _parametersItem(context, {
                            "name": TextLanguage.of(context)
                                .temperature
                                .toLowerCase(),
                            "value": 25,
                            "default": 20.0
                            // ignore: missing_return
                          }, () {
                            parametersDialog(
                                context, TextLanguage.of(context).temperature,
                                () {
                              Navigator.of(context).pop();
                              confirmationDialog(
                                  context,
                                  TextLanguage.of(context)
                                      .changeTemperatureConfirmation,
                                  // ignore: missing_return
                                  TextLanguage.of(context).setPointConfirmation,
                                  () {
                                print('yess');
                                AlertsBloc().setAlertClosed = false;
                                AlertsBloc().setAlert = Alerts(
                                    TextLanguage.of(context).updating,
                                    "Updating");
                                ParametersProvider().setParameters(
                                    context,
                                    ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .id,
                                    temperature: double.parse(
                                        ParametersBloc().parametersFieldValue),
                                    weight: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .dweight,
                                    timeout: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .timeOut);
                              }, () {
                                print('no');
                                Navigator.of(context).pop();
                              });
                            });
                            print('temp');
                          }),
                          _parametersItem(context, {
                            "name": TextLanguage.of(context)
                                .unavailable
                                .toLowerCase(),
                            "value": 6,
                            "default": 7.0
                            // ignore: missing_return
                          }, () {
                            parametersDialog(
                                context, TextLanguage.of(context).timeout, () {
                              Navigator.of(context).pop();
                              confirmationDialog(
                                  context,
                                  TextLanguage.of(context)
                                      .changeTimeoutConfirmation,
                                  // ignore: missing_return
                                  TextLanguage.of(context).setPointConfirmation,
                                  () {
                                AlertsBloc().setAlertClosed = false;
                                print('yess');
                                AlertsBloc().setAlert = Alerts(
                                    TextLanguage.of(context).updating,
                                    "Updating");
                                ParametersProvider().setParameters(
                                    context,
                                    ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .id,
                                    timeout: double.parse(
                                        ParametersBloc().parametersFieldValue),
                                    temperature: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .dtemp,
                                    weight: ParametersBloc()
                                        .parametersValue
                                        .params[0]
                                        .dweight);
                              }, () {
                                print('no');
                                Navigator.of(context).pop();
                              });
                            });
                            print('time');
                          })
                        ],
                      )),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    circularProgressCustom(),
                  ],
                );
              }
            }),
        bottomNavigationBar: botomBar(1, context),
      )),
    );
  }
}

Widget _parametersItem(BuildContext context, parameters, Function onTap()) {
  double _value;
  switch (parameters["name"]) {
    case "weight":
      _value = ParametersBloc().parametersValue.params[0].dweight;
      break;
    case "temperature":
      _value = ParametersBloc().parametersValue.params[0].dtemp;
      break;
    case "unavailable":
      _value = ParametersBloc().parametersValue.params[0].timeOut;
      break;
    default:
  }
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
                              Text(_value.toString(),
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
                            TextLanguage.of(context).parameter,
                            style: TextStyle(
                                color: blue1, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                          width: (MediaQuery.of(context).size.width - 220) / 3,
                          child: Text(TextLanguage.of(context).defaultt,
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip)),
                      Container(
                          width: (MediaQuery.of(context).size.width - 125) / 3,
                          child: Text(TextLanguage.of(context).value,
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
