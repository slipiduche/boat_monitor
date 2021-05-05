import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/pendingAlerts_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';

//import 'package:boat_monitor/widgets/manageboat_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ManageBoatPage extends StatefulWidget {
  @override
  _ManageBoatPageState createState() => _ManageBoatPageState();
}

class _ManageBoatPageState extends State<ManageBoatPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  Boats _boats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    print(_boats);
  }

  @override
  Widget build(BuildContext context) {
    _boats = Boats.fromJsonList(boatsTest);
    print(_boats);
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(TextLanguage.of(context).manageBoat,
          boatIconBlue(25.0, Colors.white), () {}),
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
            Expanded(child: makeBoatList(context, _boats.boats)),
            // StreamBuilder(
            //   stream: PendingAlertsBloc().pendingAlerts,
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

Widget makeBoatList(BuildContext context, List<Boat> boats) {
  return Container(
    child: ListView.builder(
      itemCount: boats.length,
      itemBuilder: (BuildContext context, int index) {
        print(boats[index]);
        if (index < 1) {
          return Column(
            children: [_boatHeader(context), _boatItem(context, boats[index])],
          );
        } else {
          return _boatItem(context, boats[index]);
        }
      },
    ),
  );
}

Widget _boatItem(BuildContext context, Boat boat) {
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
                            boat.boatName,
                            overflow: TextOverflow.ellipsis,
                          )),
                      SizedBox(width: 5.0),
                      GestureDetector(
                        child: editIcon(18.0, blue1),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                          width: (MediaQuery.of(context).size.width - 80) / 3,
                          child: Text(boat.dateCreated,
                              overflow: TextOverflow.clip)),
                      Container(
                          width: (MediaQuery.of(context).size.width - 125) / 3,
                          child: Text(boat.manager,
                              overflow: TextOverflow.ellipsis)),
                      SizedBox(width: 5.0),
                      GestureDetector(
                        child: editIcon(18.0, blue1),
                      )
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

Widget _boatHeader(BuildContext context) {
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
                          width: (MediaQuery.of(context).size.width - 125) / 3,
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