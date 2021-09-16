import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/argument_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boatStorageSearchBloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';
import 'package:boat_monitor/bloc/storageSearchBloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/boats_provider.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/providers/mqtt_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';

//import 'package:boat_monitor/widgets/boatdata_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class BoatDataPage extends StatefulWidget {
  int boatId;
  StorageArgument argument;
  BoatDataPage({this.boatId, this.argument});
  @override
  _BoatDataPageState createState() => _BoatDataPageState(boatId, argument);
}

class _BoatDataPageState extends State<BoatDataPage> {
  int boatId;
  StorageArgument argument;
  _BoatDataPageState(this.boatId, this.argument);
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  Boats _boats;
  AlertsBloc alerts = AlertsBloc();
  List<bool> checks = [];
  List<int> indexs = [];
  List<Journey> unfiltered = [];
  List<Journey> filtered = [];
  MQTTClientWrapper mqtt;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    BoatsBloc().setCheck = 0;
    print(_boats);
    //AuthBloc().setRoute = 'boatDataPage';
    JourneysBloc().setJourneys = null;
    BoatStorageSearchBloc().setBoatStorageSearch = '';
    mqtt = MQTTClientWrapper(() {}, (hola, hello) {});
    mqtt.prepareMqttClient();
  }

  @override
  Widget build(BuildContext context) {
    JourneyProvider().getJourneysByBoatId(context, boatIds: [boatId]);
    print(_boats);
    return Container(
      height: MediaQuery.of(context).size.height - 400,
      child: StreamBuilder(
          stream: JourneysBloc().journeys,
          builder: (context, AsyncSnapshot<List<Journey>> snapshot) {
            if (snapshot.hasData) {
              unfiltered = snapshot.data;
              return Container(
                child: StreamBuilder(
                    stream: BoatStorageSearchBloc().boatStorageSearch,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        filtered = [];
                        unfiltered.forEach((element) {
                          if (element.id.toString().startsWith(snapshot.data)) {
                            filtered.add(element);
                          }
                        });
                      } else {
                        filtered = unfiltered;
                      }
                      if (snapshot.hasData && filtered.length > 0) {
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
                                                        deleteItems(context,
                                                            checks, indexs);
                                                      },
                                                      child: Text(
                                                        TextLanguage.of(context)
                                                            .deleteFromSsd,
                                                        style: TextStyle(
                                                            decorationThickness:
                                                                2.0,
                                                            decorationColor:
                                                                blue1,
                                                            decorationStyle:
                                                                TextDecorationStyle
                                                                    .solid,
                                                            decoration:
                                                                TextDecoration
                                                                    .combine([
                                                              TextDecoration
                                                                  .underline
                                                            ]),
                                                            color: blue1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                          TextLanguage.of(context).selected,
                                          style: TextStyle(
                                              color: blue1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(' (',
                                            style: TextStyle(
                                                color: blue1,
                                                fontWeight: FontWeight.bold)),
                                        StreamBuilder(
                                            stream: BoatsBloc().check,
                                            builder: (context, snapshot) {
                                              final _checked =
                                                  snapshot.data != null
                                                      ? snapshot.data
                                                      : 0;
                                              return Text(_checked.toString(),
                                                  style: TextStyle(
                                                      color: blue1,
                                                      fontWeight:
                                                          FontWeight.bold));
                                            }),
                                        Text(')',
                                            style: TextStyle(
                                                color: blue1,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Expanded(child: makeBoatList(context, filtered)),
                              StreamBuilder(
                                stream: AlertsBloc().alert,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  print(argument);
                                  ArgumentBloc().setArgument = argument;
                                  WidgetsBinding.instance.addPostFrameCallback(
                                      (_) => onAfterBuild(context));
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
                                TextLanguage.of(context).noData,
                                style: TextStyle(
                                    color: blue1, fontSize: correoSize),
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
                    }),
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
                      TextLanguage.of(context).noData,
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
          }),
    );
  }

  Widget makeBoatList(BuildContext context, List<Journey> boats) {
    return Container(
      // height: MediaQuery.of(context).size.height - 450,
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

  Widget _boatItem(BuildContext context, Journey boat, int index) {
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
                              TextLanguage.of(context).travel +
                                  boat.id.toString(),
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(width: 5.0),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            child: Text(boat.ini.toString(),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text(boat.fWeight.toString(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 5.0),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text(
                                boat.ed
                                        .difference(boat.ini)
                                        .inHours
                                        .toString() +
                                    ' HS',
                                overflow: TextOverflow.ellipsis)),
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
                            indexs.add(filtered[i].id);
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
                              TextLanguage.of(context).travel,
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 4,
                            child: Text(TextLanguage.of(context).date + " ",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text(
                                TextLanguage.of(context).weight + " (KG)",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 4,
                            child: Text(TextLanguage.of(context).time,
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

  void deleteItems(
      BuildContext context, List<bool> checks, List<int> indexs) async {
    confirmationDialog(
        context,
        TextLanguage.of(context).deleteStorageConfirmation,
        TextLanguage.of(context).deleteConfirmation, () {
      Navigator.of(context).pop();
      //setOnJourney(_boat.id, context);
      AlertsBloc().setAlert =
          Alerts(TextLanguage.of(context).deleting, "Updating");
      //mqtt.journeyStop(_boat.id);
      for (var i = 0; i < checks.length; i++) {
        if (checks[i]) {
          mqtt.journeyDelete(journeyId: indexs[i]);
        }
      }
    }, () {
      Navigator.of(context).pop();
    });
  }
}

void changeBoatName(String name, int boatId, BuildContext context) async {
  print(name);
  print(boatId);

  AlertsBloc().setAlert = Alerts(TextLanguage.of(context).updating, "Updating");
  //updating(context, TextLanguage.of(context).loginButtonText);
  var _change = await BoatProvider().changeBoatName(name, boatId, context);
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
