import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/bloc/storageSearchBloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/boats_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/boats_provider.dart';
import 'package:boat_monitor/providers/historics_provider.dart';
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
  List<double> listStorage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    HistoricsBloc().setHistorics = null;

    _predata();
  }

  void _predata() async {
    await BoatProvider().getBoats(context);
    AuthBloc().setRoute = 'storagePage';
    StorageSearchBloc().setStorageSearch = '';
    final _boats = BoatsBloc().boatsValue;
    List<int> _listId;
    await HistoricsProvider()
        .getHistorics(context, journeyId: _listId, last: true);
    final historicsStorage = HistoricsBloc().historicsValue;
    _boats.forEach((element) {
      historicsStorage.historics.lastWhere((historic) {
        if (historic.boatId == element.id) {
          listStorage.add(historic.dsk);
          return true;
        } else {
          return false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('homePage');
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar3(
            TextLanguage.of(context).storage, storageIcon(25.0, Colors.white),
            () {
          Navigator.of(context).pushReplacementNamed('homePage');
        }),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                        stream: BoatsBloc().boats,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder<Object>(
                                stream: HistoricsBloc().historics,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      child: StreamBuilder(
                                        stream:
                                            StorageSearchBloc().storageSearch,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          List<BoatData> _boats =
                                              BoatsBloc().boatsValue;
                                          List<BoatData> _boatsFiltered = [];
                                          List<BoatData> _boatsFiltered2 = [];
                                          if (snapshot.hasData) {
                                            _boats.forEach((element) {
                                              if (element.boatName
                                                  .toLowerCase()
                                                  .contains(snapshot.data
                                                      .toLowerCase())) {
                                                print(element.boatName);
                                                print(snapshot.data
                                                    .toLowerCase());
                                                _boatsFiltered.add(element);
                                              }
                                            });
                                          } else {
                                            _boatsFiltered = _boats;
                                          }
                                          return Column(
                                            children: [
                                              makeBoatStorageList(
                                                  context, _boatsFiltered)
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: marginExt1),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          // Text(
                                          //   TextLanguage.of(context).noData,
                                          //   style: TextStyle(
                                          //       color: blue1,
                                          //       fontSize: correoSize),
                                          //   textAlign: TextAlign.center,
                                          // ),
                                          circularProgressCustom(),
                                          Divider(
                                            thickness: 1.0,
                                            color: gray1,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                });
                          } else {
                            return Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: marginExt1),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  // Text(
                                  //   TextLanguage.of(context).noData,
                                  //   style: TextStyle(
                                  //       color: blue1, fontSize: correoSize),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  circularProgressCustom(),
                                  Divider(
                                    thickness: 1.0,
                                    color: gray1,
                                  )
                                ],
                              ),
                            );
                          }
                        }),
                  ],
                )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(2, context),
      )),
    );
  }

  Widget makeBoatStorageList(BuildContext context, List<BoatData> boats) {
    if (boats.length == 0 || listStorage.length < 1) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              TextLanguage.of(context).noData,
              style: TextStyle(color: blue1, fontSize: correoSize),
              textAlign: TextAlign.center,
            ),
            Divider(
              thickness: 1.0,
              color: gray1,
            )
          ],
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height - 210,
        child: ListView.builder(
            itemCount: boats.length,
            itemBuilder: (context, index) {
              return _boatDiskCard(context, boats[index], listStorage[index]);
            }),
      );
    }
  }
}

Widget _boatDiskCard(BuildContext context, BoatData boat, double storage) {
  final _maxStorage = boat.maxSt;
  final _usedStorage = storage * _maxStorage / 100;
  return GestureDetector(
    onTap: () {
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus && focus.hasFocus) {
        FocusManager.instance.primaryFocus.unfocus();
      }
      Navigator.of(context).pushNamed('boatStoragePage',
          arguments: StorageArgument(boat: boat, usedStorage: storage));
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
                      boat.boatName,
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
                  children: [DiskSpace(storage)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${storage.round()} %',
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
                      '${_usedStorage.round()} GB/${_maxStorage.round()} GB',
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
              border: InputBorder.none,
              hintText: TextLanguage.of(context).typeAnyBoatName),
          onChanged: (value) {
            StorageSearchBloc().setStorageSearch = value;
          },
        ))
      ],
    ),
  );
}
