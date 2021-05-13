import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:boat_monitor/providers/users_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  List<bool> checks = [];
  List<int> indexs = [];
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  PendingApprovals _approvals;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    print(_approvals);
    PendingAlertsBloc().setCheck = 0;

    AuthBloc().setRoute = 'approvalPage';
  }

  @override
  Widget build(BuildContext context) {
    UserProvider().getUsers();
    _approvals = PendingApprovals.fromJsonList(pendingApprovalsTest);
    print(_approvals);
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          TextLanguage.of(context).approval, approvalsIcon(25.0, Colors.white),
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
            Expanded(
                child: makeApprovalList(context, _approvals.pendingapprovals)),
            // StreamBuilder(
            //   stream: PendingApprovalsBloc().pendingApprovals,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return Container();
            //   },
            // ),
          ],
        ),
      ),
      bottomNavigationBar: botomBar(3, context),
    ));
  }

  Widget makeApprovalList(
      BuildContext context, List<PendingApproval> approvals) {
    return Container(
      child: ListView.builder(
        itemCount: approvals.length,
        itemBuilder: (BuildContext context, int index) {
          if (checks.length < approvals.length) {
            checks.add(false);
          }
          print(approvals[index]);
          if (index < 1) {
            return Column(
              children: [
                _approvalHeader(context),
                _approvalItem(context, approvals[index], index)
              ],
            );
          } else {
            return _approvalItem(context, approvals[index], index);
          }
        },
      ),
    );
  }

  Widget _approvalItem(
      BuildContext context, PendingApproval approval, int index) {
    return Container(
      margin: EdgeInsets.only(left: marginExt1 / 2, right: marginExt1),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: checks[index],
                activeColor: blue1,
                onChanged: (value) {
                  checks[index] = value;

                  if (value == true) {
                    indexs.add(approval.pendingapprovalId);
                    PendingAlertsBloc().setCheck =
                        PendingAlertsBloc().checkValue + 1;
                  } else {
                    indexs.remove(approval.pendingapprovalId);
                    PendingAlertsBloc().setCheck =
                        PendingAlertsBloc().checkValue - 1;
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
                                (MediaQuery.of(context).size.width - 220) / 3,
                            child: Text(
                              'orbittas',
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(width: 5.0),
                        SizedBox(width: 5.0),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 3,
                            child: Text('04/05/2021 21:00',
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 3,
                            child: Text('alejandro@orbittas.com',
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
              color: blue1,
              height: 1.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _approvalHeader(BuildContext context) {
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
                              for (var i = 0; i < checks.length; i++) {
                                checks[i] = true;
                                indexs.add(PendingAlertsBloc().alertAlertsValue[i].pendingalertId);
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
                }
              ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 220) / 3,
                            child: Text(
                              'User',
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 220) / 3,
                            child: Text("Date",
                                style: TextStyle(
                                    color: blue1, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 3,
                            child: Text("Email",
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
