import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/bloc/users_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/users_model.dart';
import 'package:boat_monitor/providers/boats_provider.dart';
import 'package:boat_monitor/providers/users_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';

//import 'package:boat_monitor/widgets/manageboatresponsible_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ManageBoatResponsiblePage extends StatefulWidget {
  @override
  _ManageBoatResponsiblePageState createState() =>
      _ManageBoatResponsiblePageState();
}

class _ManageBoatResponsiblePageState extends State<ManageBoatResponsiblePage> {
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
    AuthBloc().setRoute = 'manageBoatResponsiblePage';
  }

  @override
  Widget build(BuildContext context) {
    BoatData _boat = ModalRoute.of(context).settings.arguments;
    UserProvider().getUsers();
    print(_boats);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('manageBoatPage');
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar2(
            TextLanguage.of(context).manager, boatIconBlue(25.0, Colors.white),
            () {
          Navigator.of(context).pushReplacementNamed('manageBoatPage');
        }),
        body: StreamBuilder(
            stream: UsersBloc().users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: marginExt1),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                'Select user responsible',
                                style: TextStyle(
                                  color: blue1,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Expanded(
                          child: makeBoatList(context, snapshot.data, _boat)),
                      StreamBuilder(
                        stream: AlertsBloc().alert,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                  margin: EdgeInsets.symmetric(horizontal: marginExt1),
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
            }),
        bottomNavigationBar: botomBar(3, context),
      )),
    );
  }

  Widget makeBoatList(BuildContext context, Users users, BoatData _boat) {
    List<User> approved = [];
    users.users.forEach((element) {
      if (element.approval == 1) {
        approved.add(element);
      }
    });
    return Container(
      child: ListView.builder(
        itemCount: approved.length,
        itemBuilder: (BuildContext context, int index) {
          if (checks.length < approved.length) {
            checks.add(false);
          }
          print(approved[index]);
          if (index < 1) {
            return Column(
              children: [_userItem(context, approved[index], index, _boat)],
            );
          } else {
            return _userItem(context, approved[index], index, _boat);
          }
        },
      ),
    );
  }

  void changeResponsible(BuildContext context, User user, BoatData boat) async {
    confirmationDialog(
        context,
        'Are you sure you want to change ${boat.boatName} responsible to ${user.username}?',
        'Change Confirmation', () {
      AlertsBloc().setAlert = Alerts('Change', "Updating");
      BoatProvider().changeBoatResponsible(user, boat.id);
    }, () {
      Navigator.of(context).pop();
    });
  }

  Widget _userItem(BuildContext context, User user, int index, BoatData boat) {
    return GestureDetector(
      onTap: () {
        changeResponsible(context, user, boat);
      },
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width:
                                  (MediaQuery.of(context).size.width) / 2 - 50,
                              child: Text(
                                user.names,
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(width: 5.0),
                          Container(
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: Text(user.username,
                                  overflow: TextOverflow.clip)),
                          SizedBox(width: 5.0),
                        ],
                      ),
                      Container(
                        //margin: EdgeInsets.only(left: marginExt1 * 2),
                        child: Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _boatHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
      child: Column(
        children: [
          Row(
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
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 220) / 3,
                            child: Text(
                              'Boat',
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 3,
                            child: Text("Date created",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 3,
                            child: Text("Manager",
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
