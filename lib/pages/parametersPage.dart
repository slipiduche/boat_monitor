import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ParametersPage extends StatefulWidget {
  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
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
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(TextLanguage.of(context).parameters,
          parametersIcon(25.0, Colors.white), () {}),
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
                child: Column(
              children: [_parametersHeader(context)],
            )),
            // StreamBuilder(
            //   stream: PendingParameterssBloc().pendingParameterss,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return Container();
            //   },
            // ),
          ],
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
  }
}

Widget _parametersItem(BuildContext context, parameters) {
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
                          width: (MediaQuery.of(context).size.width - 220) / 3,
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
                          width: (MediaQuery.of(context).size.width - 125) / 3,
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

Widget _parametersHeader(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: marginExt1, right: marginExt1),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 180) / 3,
                          child: Text(
                            'Parameter',
                            style: TextStyle(
                                color: blue1, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                          width: (MediaQuery.of(context).size.width - 220) / 3,
                          child: Text("Default",
                              style: TextStyle(
                                  color: blue1, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.clip)),
                      Container(
                          width: (MediaQuery.of(context).size.width - 125) / 3,
                          child: Text("Value",
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
          //margin: EdgeInsets.only(left: marginExt1 * 2),
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
