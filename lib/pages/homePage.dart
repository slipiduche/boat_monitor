import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/homeFilterBloc.dart';
import 'package:boat_monitor/bloc/homeSearchBloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/boats_provider.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    BoatProvider().getBoats(context);
    HomeSearchBloc().setHomeSearch = '';
  }

  @override
  Widget build(BuildContext context) {
    HomeFilterBloc().sethomeFilter = '';
    return WillPopScope(
      onWillPop: () {},
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar3(
            TextLanguage.of(context).home, homeIcon(25.0, Colors.white), () {}),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: marginExt1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Column(
                  children: [
                    _homeSearch(context),
                    SizedBox(
                      height: 10.0,
                    ),
                    StreamBuilder<Object>(
                        stream: HomeFilterBloc().homeFilter,
                        builder: (context, snapshot) {
                          return Container(
                            child: StreamBuilder(
                              stream: BoatsBloc().boats,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      _homeButtons(context),
                                      StreamBuilder(
                                          stream: HomeSearchBloc().homeSearch,
                                          builder: (context,
                                              AsyncSnapshot<String> snapshot) {
                                            List<BoatData> _boats =
                                                BoatsBloc().boatsValue;
                                            List<BoatData> _boatsFiltered = [];
                                            List<BoatData> _boatsFiltered2 = [];
                                            if (snapshot.hasData) {
                                              _boats.forEach((element) {
                                                if (element.boatName
                                                        .toLowerCase()
                                                        .contains(snapshot.data
                                                            .toLowerCase()) &&
                                                    element.st == 1) {
                                                  print(element.boatName);
                                                  print(snapshot.data
                                                      .toLowerCase());
                                                  _boatsFiltered.add(element);
                                                }
                                              });
                                            } else {
                                              _boats.forEach((element) {
                                                if (element.st == 1) {
                                                  print(element.boatName);

                                                  _boatsFiltered.add(element);
                                                }
                                              });
                                            }
                                            if (HomeFilterBloc()
                                                        .homeFilterValue !=
                                                    null &&
                                                HomeFilterBloc()
                                                        .homeFilterValue !=
                                                    '') {
                                              String _filter = HomeFilterBloc()
                                                  .homeFilterValue;
                                              _boatsFiltered.forEach((element) {
                                                switch (_filter) {
                                                  case 'Sailing':
                                                    if (element.onJourney ==
                                                            1 &&
                                                        element.st == 1) {
                                                      _boatsFiltered2
                                                          .add(element);
                                                    }
                                                    break;
                                                  case 'Arrived':
                                                    if (element.onJourney ==
                                                            0 &&
                                                        element.st == 1) {
                                                      _boatsFiltered2
                                                          .add(element);
                                                    }
                                                    break;
                                                  case 'unavailable':
                                                    if (element.st == 1 &&
                                                        element.connected ==
                                                            0) {
                                                      _boatsFiltered2
                                                          .add(element);
                                                    }
                                                    break;
                                                  case 'available':
                                                    if (element.st == 1 &&
                                                        element.connected ==
                                                            1) {
                                                      _boatsFiltered2
                                                          .add(element);
                                                    }
                                                    break;
                                                  default:
                                                }
                                              });
                                            } else {
                                              _boatsFiltered2 = _boatsFiltered;
                                            }
                                            return makeBoatList(
                                                context, _boatsFiltered2);
                                          })
                                    ],
                                  );
                                } else {
                                  return Container(
                                    //margin: EdgeInsets.symmetric(horizontal: marginExt1),
                                    child: Column(
                                      children: [
                                        _homeButtons(context),
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
                          );
                        }),
                  ],
                )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(0, context),
      )),
    );
  }
}

Widget makeBoatList(BuildContext context, List<BoatData> boats) {
  if (boats.length == 0) {
    return Container(
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
  } else {
    return Container(
      height: MediaQuery.of(context).size.height - 206,
      child: ListView.builder(
          itemCount: boats.length,
          itemBuilder: (context, index) {
            return _boatCard(context, boats[index]);
          }),
    );
  }
}

Widget _boatCard(BuildContext context, BoatData boat) {
  if (JourneysBloc().journeysValue == null) {
    JourneyProvider().getJourneys(context);
  }
  return StreamBuilder(
      stream: JourneysBloc().journeys,
      builder: (context, AsyncSnapshot<List<Journey>> snapshot) {
        Journey _journey;
        if (snapshot.hasData) {
          snapshot.data.forEach((element) {
            if (element.id == boat.lj) {
              _journey = element;
            }
          });
          if (_journey == null) {
            _journey = Journey(
                fWeight: 0.0,
                ed: DateTime.now(),
                ini: DateTime.now(),
                boatName: boat.boatName);
            return GestureDetector(
              onTap: () {
                final FocusScopeNode focus = FocusScope.of(context);
                if (!focus.hasPrimaryFocus && focus.hasFocus) {
                  FocusManager.instance.primaryFocus.unfocus();
                }

                Navigator.of(context).pushNamed(
                  'currentBoatPage',
                  arguments: BoatCardArguments(journey: _journey, boat: boat),
                );
              },
              child: Container(
                height: 150,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: blue1, style: BorderStyle.solid, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
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
                                boat.boatName,
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
                                TextLanguage.of(context).departure + ':',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: boatCardContent),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(TextLanguage.of(context).noData,
                                  style: TextStyle(
                                      color: blueTextBoatCard,
                                      fontSize: boatCardContent))
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                TextLanguage.of(context).arrival + ':',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: boatCardContent),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(TextLanguage.of(context).noData,
                                  style: TextStyle(
                                      color: blueTextBoatCard,
                                      fontSize: boatCardContent))
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Text(
                                TextLanguage.of(context).finalWeight + ':',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: boatCardContent),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(TextLanguage.of(context).noData,
                                  style: TextStyle(
                                      color: blueTextBoatCard,
                                      fontSize: boatCardContent))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: marginInt, top: marginSupBoatCard),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(builder: (context) {
                                print('aqui estoy colocando esto' +
                                    boat.toString());
                                if (boat.connected == 1) {
                                  return statusIcon(20.0, 2);
                                } else {
                                  return statusIcon(20.0, 0);
                                }
                              }),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                TextLanguage.of(context).status + ':',
                                style: TextStyle(
                                    color: blue1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Builder(builder: (context) {
                                if (boat.onJourney == 0 && boat.lj != null) {
                                  return Text(
                                    TextLanguage.of(context).arrived,
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  );
                                } else if (boat.lj != null) {
                                  return Text(
                                    TextLanguage.of(context).sailing,
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  );
                                } else {
                                  return Text(
                                    TextLanguage.of(context).noData,
                                    style: TextStyle(
                                        color: blue1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  );
                                }
                              }),
                              SizedBox(
                                width: 5.0,
                              ),
                              Builder(builder: (context) {
                                if (boat.onJourney == 0 && boat.lj != null) {
                                  return arrivedIcon(20.0, blue1);
                                } else if (boat.lj != null) {
                                  return boatIconBlue(25.0, blue1);
                                } else {
                                  return Container();
                                }
                              }),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }

              Navigator.of(context).pushNamed(
                'currentBoatPage',
                arguments: BoatCardArguments(journey: _journey, boat: boat),
              );
            },
            child: Container(
              height: 150,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: blue1, style: BorderStyle.solid, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0)),
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
                              boat.boatName,
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
                        Builder(builder: (context) {
                          if (boat.lj != null) {
                            return Row(
                              children: [
                                Text(
                                  TextLanguage.of(context).departure + ':',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: boatCardContent),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                    '${_journey.ini.day > 9 ? _journey.ini.day : '0${_journey.ini.day}'}/${_journey.ini.month > 9 ? _journey.ini.month : '0${_journey.ini.month}'}/${_journey.ini.year} ' +
                                        _journey.ini.toString().substring(11,
                                            _journey.ini.toString().length - 2),
                                    style: TextStyle(
                                        color: blueTextBoatCard,
                                        fontSize: boatCardContent))
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                        SizedBox(
                          height: 5.0,
                        ),
                        Builder(builder: (context) {
                          if (boat.onJourney == 0 && boat.lj != null) {
                            return Row(
                              children: [
                                Text(
                                  TextLanguage.of(context).arrival + ':',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: boatCardContent),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                    '${_journey.ed.day > 9 ? _journey.ed.day : '0${_journey.ed.day}'}/${_journey.ed.month > 9 ? _journey.ed.month : '0${_journey.ed.month}'}/${_journey.ed.year} ' +
                                        _journey.ed.toString().substring(11,
                                            _journey.ed.toString().length - 2),
                                    style: TextStyle(
                                        color: blueTextBoatCard,
                                        fontSize: boatCardContent))
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text(
                              TextLanguage.of(context).finalWeight + ':',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: boatCardContent),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(_journey.fWeight.toString() + ' KG',
                                style: TextStyle(
                                    color: blueTextBoatCard,
                                    fontSize: boatCardContent))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: marginInt, top: marginSupBoatCard),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Builder(builder: (context) {
                              if (boat.connected == 1) {
                                return statusIcon(20.0, 2);
                              } else {
                                return statusIcon(20.0, 0);
                              }
                            }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              TextLanguage.of(context).status + ':',
                              style: TextStyle(
                                  color: blue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Builder(builder: (context) {
                              if (boat.onJourney == 0 && boat.lj != null) {
                                return Text(
                                  TextLanguage.of(context).arrived,
                                  style: TextStyle(
                                      color: blue1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                );
                              } else if (boat.lj != null) {
                                return Text(
                                  TextLanguage.of(context).sailing,
                                  style: TextStyle(
                                      color: blue1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                );
                              } else {
                                return Text(
                                  TextLanguage.of(context).noData,
                                  style: TextStyle(
                                      color: blue1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                );
                              }
                            }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Builder(builder: (context) {
                              if (boat.onJourney == 0 && boat.lj != null) {
                                return arrivedIcon(20.0, blue1);
                              } else if (boat.lj != null) {
                                return boatIconBlue(25.0, blue1);
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 150,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: blue1, style: BorderStyle.solid, width: 2.0),
                borderRadius: BorderRadius.circular(10.0)),
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
                            boat.boatName,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(blue1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      });
}

Widget _homeButtons(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - (marginExt1 * 2),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _filterButton(() {
          print('salling filter');
          HomeFilterBloc().sethomeFilter = 'Sailing';
        }, TextLanguage.of(context).sailing, 'Sailing'),
        _filterButton(() {
          HomeFilterBloc().sethomeFilter = 'Arrived';
        }, TextLanguage.of(context).arrived, 'Arrived'),
        _filterButton(() {
          HomeFilterBloc().sethomeFilter = 'unavailable';
        }, TextLanguage.of(context).unavailable, 'unavailable'),
        _filterButton(() {
          HomeFilterBloc().sethomeFilter = 'available';
        }, TextLanguage.of(context).available, 'available')
      ],
    ),
  );
}

Widget _filterButton(Function onTap, String text, String status) {
  Color _color = gray;
  Color _textColor = gray1;
  double _buttonWidth = 80.0;
  if (text.length < 12) {
    _buttonWidth = 7.27 * (text.length + 1);
  }
  return StreamBuilder(
      stream: HomeFilterBloc().homeFilter,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          print(text);
          if (snapshot.data == status) {
            _color = blue1;
            _textColor = Colors.white;
          } else {
            _color = gray;
            _textColor = gray1;
          }
        } else {
          _color = gray;
          _textColor = gray1;
        }
        return GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
              height: 20.0,
              width: _buttonWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: _textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: _color, borderRadius: BorderRadius.circular(50.0))),
        );
      });
}

Widget _homeSearch(BuildContext context) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: marginExt1),
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
          style: TextStyle(color: blue1),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: TextLanguage.of(context).typeAnyBoatName),
          onChanged: (value) {
            HomeSearchBloc().setHomeSearch = value;
          },
        ))
      ],
    ),
  );
}
