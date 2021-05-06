import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/homeSearchBloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/journney_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar3(
          TextLanguage.of(context).home, homeIcon(25.0, Colors.white), () {}),
      body: Container(
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
                StreamBuilder(
                  stream: HomeSearchBloc().homeSearch,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          _homeButtons(context),
                          _boatCard(context, Journey(), 'Boat1')
                        ],
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: marginExt1),
                        child: Column(
                          children: [
                            _homeButtons(context),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'No data',
                              style:
                                  TextStyle(color: blue1, fontSize: correoSize),
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
                  },
                ),
              ],
            )),
          ],
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
  }
}

Widget _boatCard(BuildContext context, Journey journey, String boatName) {
  return Container(
    height: 150,
    margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
    decoration: BoxDecoration(
        border: Border.all(color: blue1, style: BorderStyle.solid,width: 2.0),
        borderRadius: BorderRadius.circular(5.0)),
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
                    boatName,
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
                    'Departure:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('04/05/2021 12:38',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Arrival:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('05/05/2021 12:38',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'final Weight:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: boatCardContent),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('100Kg',
                      style: TextStyle(
                          color: blueTextBoatCard, fontSize: boatCardContent))
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: marginInt, top: marginSupBoatCard),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  statusIcon(20.0, 1),
                  SizedBox(
                    width: 5.0,
                  ),
                  
                  Text(
                    'Status:',
                    style: TextStyle(
                        color: blue1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Arrived',
                    style: TextStyle(
                        color: blue1,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  arrivedIcon(20.0, blue1)
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _homeButtons(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _filterButton(() {}, 'Salling'),
        _filterButton(() {}, 'Arrived'),
        _filterButton(() {}, 'unavailable'),
        _filterButton(() {}, 'available')
      ],
    ),
  );
}

Widget _filterButton(Function onTap, String text) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: 20.0,
        width: 80.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: gray1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: gray, borderRadius: BorderRadius.circular(50.0))),
  );
}

Widget _homeSearch(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: marginExt1),
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
              border: InputBorder.none, hintText: 'Type any boat name'),
          onChanged: (value) {
            HomeSearchBloc().setHomeSearch = value;
          },
        ))
      ],
    ),
  );
}
