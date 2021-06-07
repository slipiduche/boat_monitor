import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/storageSearchBloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/storage_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class StoragePage extends StatefulWidget {
  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'storagePage';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar3(TextLanguage.of(context).storage,
          storageIcon(25.0, Colors.white), () {}),
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
                _storageSearch(context),
                SizedBox(
                  height: 10.0,
                ),
                StreamBuilder(
                  stream: StorageSearchBloc().storageSearch,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          _boatDiskCard(
                              context, Journey(boatName: 'Boat1'), 'Boat1')
                        ],
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
      bottomNavigationBar: botomBar(2, context),
    ));
  }
}

Widget _boatDiskCard(BuildContext context, Journey journey, String boatName) {
  return GestureDetector(
    onTap: () {
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus && focus.hasFocus) {
        FocusManager.instance.primaryFocus.unfocus();
      }
      Navigator.of(context).pushNamed('boatStoragePage', arguments: journey);
    },
    child: Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
      decoration: BoxDecoration(
          border:
              Border.all(color: blue1, style: BorderStyle.solid, width: 2.0),
          borderRadius: BorderRadius.circular(10.0)),
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
                  children: [DiskSpace()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${0.2 * 100} %',
                      style: TextStyle(
                          color: blue1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
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
                    Text(
                      '20GB/240GB',
                      style: TextStyle(
                          color: blue1,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
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

Widget _storageSearch(BuildContext context) {
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
            StorageSearchBloc().setStorageSearch = value;
          },
        ))
      ],
    ),
  );
}