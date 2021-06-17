import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boatStorageSearchBloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pages/boat_Storage_Data.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/storage_widgets.dart';

import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class BoatStoragePage extends StatefulWidget {
  @override
  _BoatStoragePageState createState() => _BoatStoragePageState();
}

class _BoatStoragePageState extends State<BoatStoragePage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  double _usedStorage = 20.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'boatStoragePage';
  }

  @override
  Widget build(BuildContext context) {
    StorageArgument _storage = ModalRoute.of(context).settings.arguments;
    BoatData _boat = _storage.boat;
    final _maxStorage = _boat.maxSt;
    _usedStorage = _storage.usedStorage * _maxStorage / 100;

    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          TextLanguage.of(context).storage, storageIcon(25.0, Colors.white),
          () {
        Navigator.of(context).pop();
      }),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _boat.boatName,
                          style: TextStyle(color: blue1, fontSize: correoSize),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Disk space: ',
                          style: TextStyle(
                              color: blue1,
                              fontSize: messageTitle,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_usedStorage}GB/${_maxStorage}GB',
                          style: TextStyle(
                              color: blue1,
                              fontSize: messageTitle,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${_storage.usedStorage} %',
                              style: TextStyle(
                                  color: blue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: messageTitle),
                            ),
                          ],
                        ),
                      ],
                    ),
                    DiskSpace(_storage.usedStorage),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sailling days',
                          style: TextStyle(color: blue1, fontSize: correoSize),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _boatStorageSearch(context),
                    Container(
                        height: MediaQuery.of(context).size.height - 350,
                        child: BoatDataPage(
                          boatId: _boat.id,
                          argument: _storage,
                        )),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: botomBar(2, context),
    ));
  }
}

Widget _boatStorageSearch(BuildContext context) {
  return Container(
    //margin: EdgeInsets.symmetric(horizontal: marginExt1),
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
              border: InputBorder.none, hintText: 'Type any travel'),
          onChanged: (value) {
            BoatStorageSearchBloc().setBoatStorageSearch = value;
          },
        ))
      ],
    ),
  );
}
