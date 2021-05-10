import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/managerWidgets.dart';
//import 'package:boat_monitor/widgets/manager_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
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
      onWillPop: () {},
      child: SafeArea(
          child: Scaffold(
        //appBar: gradientAppBar(TextLanguage.of(context).managerButtonText, () {}),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: marginSupicon2),
                managerIcon(100.0),
                SizedBox(height: 17.0),
                Builder(builder: (context) {
                  if (_prefs.userType == 1) {
                    return Column(
                      children: [
                        Text(
                          TextLanguage.of(context).manager,
                          style: TextStyle(
                              fontSize: correoSize,
                              fontWeight: FontWeight.bold,
                              color: blue1),
                        ),
                        SizedBox(height: 20.0),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).manageBoat,
                            blue1, boatIconBlue(20.0, blue1), () {
                          Navigator.of(context)
                              .pushReplacementNamed('manageBoatPage');
                        }, 0),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).approval, blue1,
                            approvalIcon(20.0), () {
                          Navigator.of(context)
                              .pushReplacementNamed('approvalPage');
                        }, 1),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).alerts, blue1,
                            alertsIcon(20.0, blue1), () {
                          Navigator.of(context)
                              .pushReplacementNamed('alertsPage');
                        }, 2),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).changePassword,
                            blue1, keyIcon(20.0, blue1), () {
                          Navigator.of(context)
                              .pushReplacementNamed('changePasswordPage');
                        }, 0),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).parameters,
                            blue1, parametersIcon(20.0, blue1), () {
                          Navigator.of(context)
                              .pushReplacementNamed('parametersPage');
                        }, 0),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        managerOption(TextLanguage.of(context).logout, blue1,
                            logoutIcon(20.0, blue1), () {
                          confirmationDialog(context,
                              'Are you sure to log out?', 'Confirmation', () {
                            _prefs.token = '';
                            _prefs.userType = 0;
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed('loginPage');
                          }, () {
                            Navigator.of(context).pop();
                            if (_prefs.userType == 1) {
                              Navigator.of(context)
                                  .pushReplacementNamed('managerPage');
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed('supervisorPage');
                            }
                          });
                        }, 0),
                      ],
                    );
                  } else if (_prefs.userType == 2) {
                    return Container();
                  } else {
                    return Container();
                  }
                }),
                StreamBuilder(
                  stream: PendingAlertsBloc().pendingAlerts,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(3, context),
      )),
    );
  }
}
