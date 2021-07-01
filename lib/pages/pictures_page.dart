import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/Argument_bloc.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/files_model.dart';

import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/providers/parameters.dart';

import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class PicturesPage extends StatefulWidget {
  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  bool _gridView = true;
  //TickerProvider _tickerProvider=TickerProvider();
  TabController _tabController;
  List<FileElement> _picturesUrl = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'picturesPage';
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PicturePageArgument _pictures = ModalRoute.of(context).settings.arguments;
    _picturesUrl = _pictures.pictures.files;
    final listFiltered = _picturesUrl.where((element) {
      if (element.cam == (_tabController.index + 1)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    print(listFiltered);
    //TabController _tabcontroller=TabController(length: 1, initialIndex: 0,vsync: );
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: gradientAppBar2(_pictures.journeyCardArgument.journey.boatName,
          boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context).pushReplacementNamed('journeyPage',
            arguments: _pictures.journeyCardArgument);
      }),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: marginExt1),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: marginExt1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Container()),
                            Text(
                              TextLanguage.of(context).travel.toUpperCase() +
                                  ' ${_pictures.journeyCardArgument.journey.id}',
                              style: TextStyle(
                                  color: blue1,
                                  fontSize: statusSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    AlertsBloc().setAlert =
                                        Alerts('Downloading', "Updating");
                                    final _resp = await JourneyProvider()
                                        .getFilesZip(
                                            journeyId: _pictures
                                                .journeyCardArgument
                                                .journey
                                                .id);
                                    if (_resp['ok']) {
                                      AlertsBloc().setAlert =
                                          Alerts(_resp['message'], 'Updated');
                                    } else {
                                      AlertsBloc().setAlert =
                                          Alerts(_resp['message'], 'Error');
                                    }
                                  },
                                  child: Container(
                                    child: downloadIcon(40.0, blue1),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        TextLanguage.of(context).pictures.toUpperCase(),
                        style: TextStyle(
                          color: blue1,
                          fontSize: correoSize,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: marginExt1),
                        child: Row(
                          children: [
                            Container(
                              height: 30.0,
                              width: MediaQuery.of(context).size.width -
                                  (marginExt1 * 2),
                              child: Builder(builder: (context) {
                                return TabBar(
                                    controller: _tabController,
                                    indicatorColor: blue1,
                                    onTap: (index) {
                                      setState(() {});
                                    },
                                    tabs: [
                                      Builder(builder: (context) {
                                        FontWeight _fontWeight =
                                            FontWeight.normal;
                                        print(
                                            '_tabController.index=${_tabController.index}');
                                        if (_tabController.index == 0) {
                                          _fontWeight = FontWeight.bold;
                                        }
                                        return Text(
                                          TextLanguage.of(context)
                                                  .camera
                                                  .toUpperCase() +
                                              ' 1',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: blue1,
                                              fontSize: 16.0,
                                              fontWeight: _fontWeight),
                                        );
                                      }),
                                      Builder(builder: (context) {
                                        FontWeight _fontWeight =
                                            FontWeight.normal;
                                        print(
                                            '_tabController.index=${_tabController.index}');
                                        if (_tabController.index == 1) {
                                          _fontWeight = FontWeight.bold;
                                        }
                                        return Text(
                                          TextLanguage.of(context)
                                                  .camera
                                                  .toUpperCase() +
                                              ' 2',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: blue1,
                                              fontSize: 16.0,
                                              fontWeight: _fontWeight),
                                        );
                                      }),
                                      Builder(builder: (context) {
                                        FontWeight _fontWeight =
                                            FontWeight.normal;
                                        print(
                                            '_tabController.index=${_tabController.index}');
                                        if (_tabController.index == 2) {
                                          _fontWeight = FontWeight.bold;
                                        }
                                        return Text(
                                          TextLanguage.of(context)
                                                  .camera
                                                  .toUpperCase() +
                                              ' 3',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: blue1,
                                              fontSize: 16.0,
                                              fontWeight: _fontWeight),
                                        );
                                      }),
                                    ]);
                              }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            picturesIcon(20.0, blue1),
                            SizedBox(width: 3.0),
                            Text(
                              '${listFiltered.length} ' +
                                  TextLanguage.of(context).pictures,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: blue1,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              child: gridListIcon(60.0, blue1),
                              onTap: () {
                                _gridView = !_gridView;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Builder(builder: (context) {
                        if (_gridView && (listFiltered.length > 0)) {
                          return Container(
                              height: MediaQuery.of(context).size.height - 338,
                              width: MediaQuery.of(context).size.width -
                                  (marginExt1 * 2),
                              child: GridView.count(
                                crossAxisCount: 3,
                                children:
                                    List.generate(_picturesUrl.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: picture2(
                                        context,
                                        Parameters().domain +
                                            listFiltered[index].flUrl,
                                        false),
                                  );
                                }),
                              ));
                        } else if (listFiltered.length > 0) {
                          return Container(
                            height: MediaQuery.of(context).size.height - 338,
                            width: MediaQuery.of(context).size.width -
                                (marginExt1 * 2),
                            child: ListView(
                              children:
                                  List.generate(_picturesUrl.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: picture2(
                                      context,
                                      Parameters().domain +
                                          listFiltered[index].flUrl,
                                      false),
                                );
                              }),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height - 338,
                            width: MediaQuery.of(context).size.width -
                                (marginExt1 * 2),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ],
            )),
            StreamBuilder(
              stream: AlertsBloc().alert,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                ArgumentBloc().setArgument = _pictures;
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => onAfterBuild(_scaffoldKey.currentContext));
                return Container();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
  }
}
