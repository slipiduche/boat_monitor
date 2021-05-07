import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/pendingAlerts_model.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  PendingAlerts _alerts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    print(_alerts);
  }

  @override
  Widget build(BuildContext context) {
    _alerts = PendingAlerts.fromJsonList(pendingAlertsTest);
    print(_alerts);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('managerPage');
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar2(
            TextLanguage.of(context).alerts, alertsIcon(25.0, Colors.white),
            () {
          Navigator.of(context).pushReplacementNamed('managerPage');
        }),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              // Container(
              //   margin: EdgeInsets.only(right: marginExt1),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Checkbox(
              //         value: true,
              //         onChanged: (value) {},
              //         activeColor: blue1,
              //       ),
              //       Text(
              //         'Selected',
              //         style: TextStyle(color: blue1, fontWeight: FontWeight.bold),
              //       ),
              //       Text(' (',
              //           style:
              //               TextStyle(color: blue1, fontWeight: FontWeight.bold)),
              //       Text("3",
              //           style:
              //               TextStyle(color: blue1, fontWeight: FontWeight.bold)),
              //       Text(')',
              //           style:
              //               TextStyle(color: blue1, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              // ),
              Expanded(child: makeAlertList(context, _alerts.pendingalerts)),
              // StreamBuilder(
              //   stream: PendingAlertsBloc().pendingAlerts,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return Container();
              //   },
              // ),
            ],
          ),
        ),
        bottomNavigationBar: botomBar(3, context),
      )),
    );
  }
}

Widget makeAlertList(BuildContext context, List<PendingAlert> alerts) {
  return Container(
    child: ListView.builder(
      itemCount: alerts.length,
      itemBuilder: (BuildContext context, int index) {
        print(alerts[index]);
        if (index < 1) {
          return Column(
            children: [
              _alertHeader(context),
              _alertItem(context, alerts[index])
            ],
          );
        } else {
          return _alertItem(context, alerts[index]);
        }
      },
    ),
  );
}

Widget _alertItem(BuildContext context, PendingAlert alert) {
  return Container(
    margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
    child: Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: true,
              activeColor: blue1,
              onChanged: (value) {},
            ),
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 90),
                          child: Text(alert.message,
                              maxLines: 2,
                              textAlign: TextAlign.justify,
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
            Checkbox(
              value: true,
              activeColor: blue1,
              onChanged: (value) {},
            ),
            // Expanded(
            //   child: Column(
            //     //mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           Container(
            //               width: (MediaQuery.of(context).size.width - 220) / 3,
            //               child: Text(
            //                 'Alert',
            //                 style: TextStyle(
            //                     color: blue1, fontWeight: FontWeight.bold),
            //                 overflow: TextOverflow.ellipsis,
            //               )),
            //           Container(
            //               width: (MediaQuery.of(context).size.width - 80) / 3,
            //               child: Text("Date created",
            //                   style: TextStyle(
            //                       color: blue1, fontWeight: FontWeight.bold),
            //                   overflow: TextOverflow.clip)),
            //           Container(
            //               width: (MediaQuery.of(context).size.width - 125) / 3,
            //               child: Text("Manager",
            //                   style: TextStyle(
            //                       color: blue1, fontWeight: FontWeight.bold),
            //                   overflow: TextOverflow.ellipsis)),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
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
