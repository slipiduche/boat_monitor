import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/providers/boats_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';

//import 'package:boat_monitor/widgets/boatdata_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class BoatDataPage extends StatefulWidget {
  @override
  _BoatDataPageState createState() => _BoatDataPageState();
}

class _BoatDataPageState extends State<BoatDataPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  Boats _boats;
  AlertsBloc alerts = AlertsBloc();
  List<bool> checks = [];
  List<int> indexs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    BoatsBloc().setCheck = 0;
    print(_boats);
    AuthBloc().setRoute = 'boatDataPage';
  }

  @override
  Widget build(BuildContext context) {
    BoatProvider().getBoats();
    print(_boats);
    return StreamBuilder(
        stream: BoatsBloc().boats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: marginExt1),
                    child: Row(
                      children: [
                        StreamBuilder(
                            stream: BoatsBloc().check,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data > 0) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print(checks);
                                            print(indexs);
                                            deleteItems(checks, indexs);
                                          },
                                          child: Text(
                                            'Delete from SSD',
                                            style: TextStyle(
                                                decorationThickness: 2.0,
                                                decorationColor: blue1,
                                                decorationStyle:
                                                    TextDecorationStyle.solid,
                                                decoration:
                                                    TextDecoration.combine([
                                                  TextDecoration.underline
                                                ]),
                                                color: blue1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]);
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Selected',
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                            ),
                            Text(' (',
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold)),
                            StreamBuilder(
                                stream: BoatsBloc().check,
                                builder: (context, snapshot) {
                                  final _checked =
                                      snapshot.data != null ? snapshot.data : 0;
                                  return Text(_checked.toString(),
                                      style: TextStyle(
                                          color: blue1,
                                          fontWeight: FontWeight.bold));
                                }),
                            Text(')',
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(child: makeBoatList(context, snapshot.data)),
                  StreamBuilder(
                    stream: AlertsBloc().alert,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => onAfterBuild(context));
                      return Container();
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container(
              //margin: EdgeInsets.symmetric(horizontal: marginExt1),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'No data',
                    style: TextStyle(color: blue1, fontSize: correoSize),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    thickness: 1.0,
                    color: gray1,
                  )
                ],
              ),
            );
          }
        });
  }

  Widget makeBoatList(BuildContext context, List<BoatData> boats) {
    return Container(
      child: ListView.builder(
        itemCount: boats.length,
        itemBuilder: (BuildContext context, int index) {
          if (checks.length < boats.length) {
            checks.add(false);
          }
          print(boats[index]);
          if (index < 1) {
            return Column(
              children: [
                _boatHeader(context),
                _boatItem(context, boats[index], index)
              ],
            );
          } else {
            return _boatItem(context, boats[index], index);
          }
        },
      ),
    );
  }

  Widget _boatItem(BuildContext context, BoatData boat, int index) {
    return Container(
      width: (MediaQuery.of(context).size.width - (marginExt1 * 2)),
      //margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: checks[index],
                activeColor: blue1,
                onChanged: (value) {
                  checks[index] = value;

                  if (value == true) {
                    indexs.add(boat.id);
                    BoatsBloc().setCheck = BoatsBloc().checkValue + 1;
                  } else {
                    indexs.remove(boat.id);
                    BoatsBloc().setCheck = BoatsBloc().checkValue - 1;
                  }
                  setState(() {});
                },
              ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 180) / 4,
                            child: Text(
                              'Travel 1',
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(width: 5.0),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            child: Text(boat.dt.toString(),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text('100',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 5.0),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child:
                                Text('10hs', overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: marginExt1 * 2),
            child: Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _boatHeader(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - (marginExt1 * 2)),
      //margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: BoatsBloc().check,
                  builder: (context, snapshot) {
                    bool _checked = false;
                    if (snapshot.hasData) {
                      if (snapshot.data > 0) {
                        _checked = true;
                      }
                    }

                    return Checkbox(
                      value: _checked,
                      onChanged: (value) {
                        if (value) {
                          for (var i = 0; i < checks.length; i++) {
                            checks[i] = true;
                            indexs.add(BoatsBloc().boatsValue[i].id);
                          }
                          BoatsBloc().setCheck = checks.length;
                        } else {
                          indexs = [];
                          for (var i = 0; i < checks.length; i++) {
                            checks[i] = false;
                          }

                          BoatsBloc().setCheck = 0;
                        }
                        setState(() {});
                      },
                      activeColor: blue1,
                    );
                  }),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 180) / 4,
                            child: Text(
                              'Travel',
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            child: Text("Date ",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text("Weight (KG)",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text("Time",
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
            margin: EdgeInsets.only(left: marginExt1 * 2),
            child: Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

void deleteItems(List<bool> checks, List<int> indexs) async {}
void changeBoatName(String name, int boatId, BuildContext context) async {
  print(name);
  print(boatId);

  AlertsBloc().setAlert = Alerts('Updating', "Updating");
  //updating(context, TextLanguage.of(context).loginButtonText);
  var _change = await BoatProvider().changeBoatName(name, boatId);
  print(_change);
  if (_change["ok"] == true) {
    // Navigator.of(context).pop();
    print(_change["message"]);
    AlertsBloc().setAlert = Alerts(_change["message"], "Updated");

    //
  } else {
    print(_change["message"]);
    AlertsBloc().setAlert = Alerts(_change["message"], "Error");
  }
}
