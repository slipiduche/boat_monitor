import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/bloc/pendingApprovals_bloc.dart';
import 'package:boat_monitor/bloc/server_alerts_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:boat_monitor/models/server_alerts_model.dart';
import 'package:boat_monitor/providers/server_alerts_provider.dart';
import 'package:boat_monitor/providers/users_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/managerWidgets.dart';
//import 'package:boat_monitor/widgets/manager_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class SupervisorPage extends StatefulWidget {
  @override
  _SupervisorPageState createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'supervisorPage';
    UserProvider().getUsers(context);

    UserProvider().getUserById(context, _prefs.userId);
    AlertsProvider().getAlerts(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: SafeArea(
          child: Scaffold(
        //appBar: gradientAppBar(TextLanguage.of(context).supervisor, () {}),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: marginSupicon2),
                supervisorIcon(100.0),
                SizedBox(height: 17.0),
                Builder(builder: (context) {
                  if (_prefs.userType == 1) {
                    return Column(
                      children: [
                        Text(
                          TextLanguage.of(context).supervisor,
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
                        StreamBuilder(
                            stream: ServerAlertsBloc().alerts,
                            builder: (context,
                                AsyncSnapshot<ServerAlerts> snapshot) {
                              if (snapshot.hasData) {
                                final _lastAlertViewedId =
                                    PendingAlertsBloc().lastAlertViewedValue;
                                int pendingAlerts = 0;
                                if (_lastAlertViewedId != null &&
                                    snapshot.data.alerts.length > 0) {
                                  pendingAlerts = snapshot.data.alerts.last.id -
                                      _lastAlertViewedId;
                                } else {
                                  pendingAlerts = snapshot.data.alerts.length;
                                }
                                if (pendingAlerts <= 0) {
                                  return managerOption(
                                      TextLanguage.of(context).alerts,
                                      blue1,
                                      alertsIcon(20.0, blue1), () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('alertsPage');
                                  }, 0);
                                }
                                return managerOption(
                                    TextLanguage.of(context).alerts,
                                    blue1,
                                    alertsIcon(20.0, blue1), () async {
                                  await UserProvider().alertViewed(
                                      context,
                                      _prefs.userId,
                                      snapshot.data.alerts.last.id);
                                  Navigator.of(context)
                                      .pushReplacementNamed('alertsPage');
                                }, pendingAlerts);
                              } else {
                                return managerOption(
                                    TextLanguage.of(context).alerts,
                                    blue1,
                                    alertsIcon(20.0, blue1), () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('alertsPage');
                                }, 0);
                              }
                            }),
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
                        managerOption(TextLanguage.of(context).logout, blue1,
                            logoutIcon(20.0, blue1), () {
                          confirmationDialog(
                              context,
                              TextLanguage.of(context).logoutConfirmation,
                              TextLanguage.of(context).confirmation, () {
                            _prefs.token = '';
                            _prefs.userType = 0;
                            HistoricsBloc().setHistorics = null;
                            BoatsBloc().setBoats = null;
                            JourneysBloc().setJourneys = null;
                            ServerAlertsBloc().setAlerts = null;
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed('loginPage');
                          }, () {
                            Navigator.of(context).pop();
                            if (_prefs.userType > 1) {
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
