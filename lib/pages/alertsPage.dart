import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/bloc/server_alerts_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/pendingAlerts_model.dart';
import 'package:boat_monitor/models/server_alerts_model.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  List<bool> checks = [];
  List<int> indexs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    PendingAlertsBloc().setCheck = 0;
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
        appBar: gradientAppBar2(
            TextLanguage.of(context).alerts, alertsIcon(25.0, Colors.white),
            () {
          if (_prefs.userType > 1) {
            Navigator.of(context).pushReplacementNamed('managerPage');
          } else {
            Navigator.of(context).pushReplacementNamed('supervisorPage');
          }
        }),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: ServerAlertsBloc().alerts,
                      builder: (context, AsyncSnapshot<ServerAlerts> snapshot) {
                        List<PendingAlert> _alerts = [];
                        if (snapshot.hasData) {
                          snapshot.data.alerts.forEach((element) {
                            _alerts.add(PendingAlert(
                                sus: element.sus,
                                ua: element.ua,
                                ta: element.ta,
                                wa: element.wa,
                                boatId: element.boatId,
                                message: element.descr,
                                pendingalertId: element.id,
                                travelId: element.journeyId,
                                date: element.dt));
                          });
                          PendingAlertsBloc().setPendingAlerts = _alerts;
                          return StreamBuilder<int>(
                              stream: PendingAlertsBloc().check,
                              builder: (context, snapshot) {
                                return makeAlertList(context, _alerts);
                              });
                        } else {
                          return Container();
                        }
                      })),
            ],
          ),
        ),
        bottomNavigationBar: botomBar(3, context),
      )),
    );
  }

  Widget makeAlertList(BuildContext context, List<PendingAlert> alerts) {
    return Container(
      child: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (BuildContext context, int index) {
          if (checks.length < alerts.length) {
            checks.add(false);
          }
          // print(checks);
          // print(alerts[index]);
          if (index < alerts.length) {
            return Column(
              children: [
                // _alertHeader(context),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginExt1),
                  child: Divider(
                    color: blue1,
                    height: 1.0,
                    thickness: 1.0,
                  ),
                ),
                _alertItem(context, alerts[alerts.length - 1 - index], index)
              ],
            );
          } else {
            return _alertItem(context, alerts[index], index);
          }
        },
      ),
    );
  }

  Widget _alertItem(BuildContext context, PendingAlert alert, int index) {
    String typeAlert, alertMessage;
    // print("Alert:");
    // print(alert.ua);
    // print("Date:");
    // print(alert.date);
    if (alert.ta == 1) {
      typeAlert = TextLanguage.of(context).tempAlert;
    } else if (alert.ua == 1) {
      typeAlert = TextLanguage.of(context).unreachableAlert;
    } else if (alert.wa == 1) {
      typeAlert = TextLanguage.of(context).weigthAlert;
    } else if (alert.sus == 1) {
      typeAlert = TextLanguage.of(context).suspiciousAlert;
    }
    if (alert.travelId != null) {
      alertMessage =
          '$typeAlert, ${TextLanguage.of(context).inJourney} ${alert.travelId}, ${TextLanguage.of(context).inBoat} ${alert.boatId}, ${TextLanguage.of(context).at} "${alert.date.day > 9 ? '${alert.date.day}' : '0${alert.date.day}'}/${alert.date.month > 9 ? '${alert.date.month}' : '0${alert.date.month}'}/${alert.date.year.toString().substring(2, 4)}" ${alert.date.toString().substring(11, alert.date.toString().length - 5)}';
    } else {
      alertMessage =
          '$typeAlert, ${TextLanguage.of(context).inBoat} ${alert.boatId}, ${TextLanguage.of(context).at} "${alert.date.day > 9 ? '${alert.date.day}' : '0${alert.date.day}'}/${alert.date.month > 9 ? '${alert.date.month}' : '0${alert.date.month}'}/${alert.date.year.toString().substring(2, 4)}" ${alert.date.toString().substring(11, alert.date.toString().length - 5)}';
    }

    return Container(
      height: 50.0,
      margin: EdgeInsets.only(left: marginExt1, right: marginExt1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: (MediaQuery.of(context).size.width -
                                  (marginExt1 * 2)),
                              child: Text(alertMessage,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
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

  Widget _alertHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
      child: Column(
        children: [
          Row(
            children: [
              StreamBuilder(
                  stream: PendingAlertsBloc().check,
                  builder: (context, snapshot) {
                    bool _checked = false;
                    if (snapshot.hasData) {
                      if (snapshot.data > 0) {
                        _checked = true;
                      }
                    }
                    return Checkbox(
                      value: _checked,
                      activeColor: blue1,
                      onChanged: (value) {
                        if (value) {
                          print('chcaks');
                          print(checks);
                          for (var i = 0; i < checks.length; i++) {
                            checks[i] = true;
                            indexs.add(PendingAlertsBloc()
                                .pendingAlertsValue[i]
                                .pendingalertId);
                          }
                          PendingAlertsBloc().setCheck = checks.length;
                        } else {
                          indexs = [];
                          for (var i = 0; i < checks.length; i++) {
                            checks[i] = false;
                          }

                          PendingAlertsBloc().setCheck = 0;
                        }
                        setState(() {});
                      },
                    );
                  }),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: marginExt1 * 2),
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
}
