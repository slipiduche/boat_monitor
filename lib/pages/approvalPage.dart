import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/pendingApprovals_bloc.dart';
import 'package:boat_monitor/bloc/users_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:boat_monitor/models/users_model.dart';
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
    PendingApprovalsBloc().setCheck = 0;

    AuthBloc().setRoute = 'approvalPage';
    UserProvider().getUsers();
  }

  @override
  Widget build(BuildContext context) {
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
                child: StreamBuilder(
                    stream: UsersBloc().users,
                    builder: (context, AsyncSnapshot<Users> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: marginExt1),
                              child: Row(
                                children: [
                                  StreamBuilder(
                                      stream: PendingApprovalsBloc().check,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data > 0) {
                                            return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('approve');
                                                      print(checks);
                                                      print(indexs);
                                                      // deleteItems(context,
                                                      //     checks, indexs);
                                                    },
                                                    child: Text(
                                                      'Approve',
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
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('decline');
                                                      print(checks);
                                                      print(indexs);
                                                      // deleteItems(context,
                                                      //     checks, indexs);
                                                    },
                                                    child: Text(
                                                      'Approve',
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
                                                              FontWeight.bold),
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
                                        'Selected',
                                        style: TextStyle(
                                            color: blue1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(' (',
                                          style: TextStyle(
                                              color: blue1,
                                              fontWeight: FontWeight.bold)),
                                      StreamBuilder(
                                          stream: PendingApprovalsBloc().check,
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
                            makeApprovalList(context, snapshot.data),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    })),
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

  Widget makeApprovalList(BuildContext context, Users users) {
    PendingApprovals approvals = PendingApprovals();
    users.users.forEach((element) {
      if (element.approval == 0) {
        approvals.pendingapprovals.add(PendingApproval(
            pendingapprovalId: element.id,
            dt: element.dt,
            userName: element.username,
            names: element.names));
      }
    });
    return Container(
      child: ListView.builder(
        itemCount: approvals.pendingapprovals.length,
        itemBuilder: (BuildContext context, int index) {
          if (checks.length < approvals.pendingapprovals.length) {
            checks.add(false);
          }
          print(approvals.pendingapprovals[index]);
          if (index < 1) {
            return Column(
              children: [
                _approvalHeader(context),
                _approvalItem(context, approvals.pendingapprovals[index], index)
              ],
            );
          } else {
            return _approvalItem(
                context, approvals.pendingapprovals[index], index);
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
                    PendingApprovalsBloc().setCheck =
                        PendingApprovalsBloc().checkValue + 1;
                  } else {
                    indexs.remove(approval.pendingapprovalId);
                    PendingApprovalsBloc().setCheck =
                        PendingApprovalsBloc().checkValue - 1;
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
                                (MediaQuery.of(context).size.width - 200) / 3,
                            child: Text(
                              approval.names,
                              overflow: TextOverflow.clip,
                            )),
                        SizedBox(width: 5.0),
                        Container(
                            width: (MediaQuery.of(context).size.width - 80) / 3,
                            child: Text(approval.dt.toIso8601String(),
                                overflow: TextOverflow.clip)),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width - 125) / 3,
                            child: Text(approval.userName,
                                overflow: TextOverflow.clip)),
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
                  stream: PendingApprovalsBloc().check,
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
                            indexs.add(PendingApprovalsBloc()
                                .alertApprovalsValue
                                .pendingapprovals[i]
                                .pendingapprovalId);
                          }
                          PendingApprovalsBloc().setCheck = checks.length;
                        } else {
                          indexs = [];
                          for (var i = 0; i < checks.length; i++) {
                            checks[i] = false;
                          }

                          PendingApprovalsBloc().setCheck = 0;
                        }
                        setState(() {});
                      },
                    );
                  }),
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
