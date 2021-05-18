import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/historySearchBloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'historyPage';
  }

  @override
  Widget build(BuildContext context) {
    JourneyProvider().getJourneys();
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar3(TextLanguage.of(context).history,
          historyIcon(25.0, Colors.white), () {}),
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
                      builder: (context, snapshot) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginExt1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showDateRangePicker(
                                            currentDate: DateTime.now(),
                                              context: context,
                                              initialEntryMode:
                                                  DatePickerEntryMode.input,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2050),
                                              
                                              );
                                        },
                                        child: calendarIcon(40.0, blue1)),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    StreamBuilder(
                                      stream: HistorySearchBloc().historySearch,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        return Container(
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                                color: blue1,
                                                fontSize: titleBarSize),
                                          ),
                                        );
                                      },
                                    ),
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
                                    AsyncSnapshot<String> snapshot) {
                                  List<Journey> _journeys =
                                      JourneysBloc().journeysValue;
                                  List<Journey> _journeysFiltered = [];
                                  if (_journeys != null) {
                                    if (snapshot.hasData) {
                                      _journeys.forEach((element) {
                                        if (element.ini
                                            .toString()
                                            .contains(snapshot.data)) {
                                          _journeysFiltered.add(element);
                                        }
                                      });
                                    } else {
                                      _journeysFiltered = _journeys;
                                    }

                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: marginExt1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        5 -
                                                    30,
                                                child: Text(
                                                  'Travel',
                                                  textAlign: TextAlign.start,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(
                                                  'Initial date',
                                                  textAlign: TextAlign.center,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(
                                                  'Final date',
                                                  textAlign: TextAlign.center,
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
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        5 -
                                                    45,
                                                child: Text(
                                                  'Boat',
                                                  textAlign: TextAlign.start,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(
                                                  'Supervisor',
                                                  textAlign: TextAlign.end,
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
                                            child: makeTravelList(
                                                context, _journeysFiltered))
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
                                          Text(
                                            'No data',
                                            style: TextStyle(
                                                color: blue1,
                                                fontSize: correoSize),
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
                                },
                              ),
                            ],
                          ),
                        );
                      }),
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

Widget makeTravelList(BuildContext context, List<Journey> journeys) {
  return Container(
    child: ListView.builder(
      itemCount: journeys.length,
      itemBuilder: (BuildContext context, int index) {
        print(journeys[index]);
        return _travelCard(context, journeys[index]);
      },
    ),
  );
}

Widget _travelCard(BuildContext context, Journey journey) {
  return Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      'travel ${journey.id}',
                      textAlign: TextAlign.start,
                      style: TextStyle(

                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.ini}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.ed}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.boatId}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.startUser}',
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
      ]));
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
              hintText: 'Type any boat name, data travel, supervisor'),
          onChanged: (value) {
            HistorySearchBloc().setHistorySearch = value;
          },
        ))
      ],
    ),
  );
}
