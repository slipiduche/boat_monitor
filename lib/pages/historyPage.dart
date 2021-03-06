import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/bloc/historySearchBloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  DateTimeRange range;
  List<Journey> _journeysFiltered = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'historyPage';
    HistorySearchBloc().setHistorySearch = HistorySearch(content: '');
  }

  @override
  Widget build(BuildContext context) {
    JourneyProvider().getJourneys(context);
    double _extraSize = 0;
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('homePage');
      },
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: gradientAppBar2(
            TextLanguage.of(context).history, historyIcon(25.0, Colors.white),
            () {
          Navigator.of(context).pushReplacementNamed('homePage');
        }),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Column(
                  children: [
                    StreamBuilder(
                        stream: JourneysBloc().journeys,
                        builder:
                            (context, AsyncSnapshot<List<Journey>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: marginExt1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                              onTap: () async {
                                                range =
                                                    await showDateRangePicker(
                                                  currentDate: DateTime.now(),
                                                  context: context,
                                                  initialEntryMode:
                                                      DatePickerEntryMode.input,
                                                  firstDate: DateTime(2020),
                                                  lastDate: DateTime(2050),
                                                );

                                                HistorySearchBloc()
                                                        .setHistorySearch =
                                                    HistorySearch(
                                                        range: range,
                                                        content: '');

                                                print(range);
                                              },
                                              child: calendarIcon(40.0, blue1)),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          StreamBuilder(
                                            stream: HistorySearchBloc()
                                                .historySearch,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<HistorySearch>
                                                    snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data.range != null) {
                                                return Container(
                                                  child: Text(
                                                    '${snapshot.data.range.start.toString().substring(0, 11)} - ${snapshot.data.range.end.toString().substring(0, 11)}',
                                                    style: TextStyle(
                                                        color: blue1,
                                                        fontSize: titleBarSize),
                                                  ),
                                                );
                                              } else {
                                                return Container(
                                                  child: Text(
                                                    TextLanguage.of(context)
                                                        .all,
                                                    style: TextStyle(
                                                        color: blue1,
                                                        fontSize: titleBarSize),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Expanded(child: Container()),
                                          GestureDetector(
                                            onTap: () async {
                                              AlertsBloc().setAlert = Alerts(
                                                  TextLanguage.of(context)
                                                      .downloading,
                                                  "Updating");
                                              final _resp =
                                                  await JourneyProvider()
                                                      .getJourneysBy(context,
                                                          _journeysFiltered);
                                              if (_resp['ok']) {
                                                AlertsBloc().setAlert = Alerts(
                                                    _resp['message'],
                                                    'Updated');
                                              } else {
                                                AlertsBloc().setAlert = Alerts(
                                                    _resp['message'], 'Error');
                                              }
                                            },
                                            child: Container(
                                              child: downloadIcon(40.0, blue1),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    _historySearch(context),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    StreamBuilder(
                                      stream: HistorySearchBloc().historySearch,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<HistorySearch>
                                              snapshot) {
                                        List<Journey> _journeys =
                                            JourneysBloc().journeysValue;
                                        _journeysFiltered = [];
                                        if (_journeys != null) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data.range != null) {
                                              _journeys.forEach((element) {
                                                if (element.ini.isAfter(snapshot
                                                        .data.range.start) &&
                                                    element.ini.isBefore(
                                                        snapshot.data.range.end
                                                            .add(
                                                                Duration(
                                                                    hours: 23,
                                                                    minutes: 59,
                                                                    seconds:
                                                                        59)))) {
                                                  _journeysFiltered
                                                      .add(element);
                                                }
                                              });
                                            } else {
                                              _journeys.forEach((element) {
                                                if (element.boatName
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(snapshot
                                                            .data.content) ||
                                                    element.endUserNames
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(snapshot
                                                            .data.content) ||
                                                    element.ini
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(snapshot
                                                            .data.content) ||
                                                    element.ed
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(snapshot
                                                            .data.content) ||
                                                    element.id
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(snapshot
                                                            .data.content)) {
                                                  _journeysFiltered
                                                      .add(element);
                                                }
                                              });
                                            }
                                          } else {
                                            _journeysFiltered = _journeys;
                                          }
                                          if (MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              770) {
                                            _extraSize = 5.0;
                                          }

                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: marginExt1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: Text(
                                                        TextLanguage.of(context)
                                                            .initialDate,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                privacyPolicySize +
                                                                    2.0),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: Text(
                                                        TextLanguage.of(context)
                                                            .finalDate,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                privacyPolicySize +
                                                                    2.0),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  5 -
                                                              40,
                                                      child: Text(
                                                        TextLanguage.of(context)
                                                            .boat,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                privacyPolicySize +
                                                                    2.0),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  5 +
                                                              _extraSize,
                                                      child: Text(
                                                        TextLanguage.of(context)
                                                            .supervisor,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color: blue1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                privacyPolicySize +
                                                                    2.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: marginExt1),
                                                child: Divider(
                                                  color: gray1,
                                                  thickness: 1.0,
                                                ),
                                              ),
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      254,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: marginExt1),
                                                  child: makeTravelList(context,
                                                      _journeysFiltered)),
                                            ],
                                          );
                                        } else {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: marginExt1),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                // Text(
                                                //   TextLanguage.of(context).noData,
                                                //   style: TextStyle(
                                                //       color: blue1,
                                                //       fontSize: correoSize),
                                                //   textAlign: TextAlign.center,
                                                // ),
                                                circularProgressCustom(),
                                                Divider(
                                                  thickness: 1.0,
                                                  color: gray1,
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginExt1),
                                child: Column(
                                  children: [
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
                          } else {
                            return Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: marginExt1),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  circularProgressCustom(),
                                  Divider(
                                    thickness: 1.0,
                                    color: gray1,
                                  )
                                ],
                              ),
                            );
                          }
                        }),
                  ],
                )),
                StreamBuilder(
                  stream: AlertsBloc().alert,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (auth.routeValue == 'historyPage') {
                      print('paso por aca');
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => onAfterBuild(_scaffoldKey.currentContext));
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(1, context),
      )),
    );
  }
}

Widget makeTravelList(BuildContext context, List<Journey> journeys) {
  return Container(
    child: ListView.builder(
      itemCount: journeys.length,
      itemBuilder: (BuildContext context, int index) {
        print(journeys[index]);
        bool _visible = false;
        if (index == journeys.length - 1) {
          _visible = true;
        }
        return Column(
          children: [
            _travelCard(context, journeys[journeys.length - index - 1]),
            Visibility(
                visible: _visible,
                child: SizedBox(
                  height: 100.0,
                ))
          ],
        );
      },
    ),
  );
}

Widget _travelCard(BuildContext context, Journey journey) {
  return GestureDetector(
    onTap: () {
      Navigator.pushReplacementNamed(context, 'journeyPage',
          arguments: JourneyCardArgument(
              historics: HistoricsBloc().historicsValue, journey: journey));
    },
    child: Container(
        //height: 150,
        //margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: gray1)),
          //borderRadius: BorderRadius.circular(5.0)
        ),
        child: Stack(children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5 - 15,
                      child: Text(
                        '${journey.ini.day > 9 ? '${journey.ini.day}' : '0${journey.ini.day}'}/${journey.ini.month > 9 ? '${journey.ini.month}' : '0${journey.ini.month}'}/${journey.ini.year.toString().substring(2, 4)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            //color: blue1,
                            //fontWeight: FontWeight.bold,
                            fontSize: privacyPolicySize + 2.0),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Builder(builder: (context) {
                      if (journey.ed == journey.ini || journey.ed == null) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 5 - 15,
                          child: Text(
                            '--',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                //color: blue1,
                                //fontWeight: FontWeight.bold,
                                fontSize: privacyPolicySize + 2.0),
                          ),
                        );
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width / 5 - 15,
                          child: Text(
                            '${journey.ed.day > 9 ? '${journey.ed.day}' : '0${journey.ed.day}'}/${journey.ed.month > 9 ? '${journey.ed.month}' : '0${journey.ed.month}'}/${journey.ed.year.toString().substring(2, 4)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                //color: blue1,
                                //fontWeight: FontWeight.bold,
                                fontSize: privacyPolicySize + 2.0),
                          ),
                        );
                      }
                    }),
                    SizedBox(
                      width: 1.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5 - 30,
                      child: Text(
                        '${journey.boatName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            //color: blue1,
                            //fontWeight: FontWeight.bold,
                            fontSize: privacyPolicySize + 2.0),
                      ),
                    ),
                    SizedBox(
                      width: 1.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5 - 10,
                      child: Text(
                        '${journey.startUserNames}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            //color: blue1,
                            //fontWeight: FontWeight.bold,
                            fontSize: privacyPolicySize + 2.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ])),
  );
}

Widget _filterButton(Function onTap, String text) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: 20.0,
        width: 80.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: gray1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: gray, borderRadius: BorderRadius.circular(50.0))),
  );
}

Widget _historySearch(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: marginExt1),
    height: 50.0,
    decoration: BoxDecoration(
        border: Border.all(color: blue1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(5.0)),
    child: Row(
      children: [
        SizedBox(
          width: 5.0,
        ),
        searchIcon(30.0, blue1),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
            child: TextField(
          style: TextStyle(color: blue1, fontSize: 15.0),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: TextLanguage.of(context).historyHintText),
          onChanged: (value) {
            HistorySearchBloc().setHistorySearch =
                HistorySearch(content: value);
          },
        ))
      ],
    ),
  );
}
