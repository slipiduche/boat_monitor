import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';

import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/argument_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/bloc/pictures_bloc.dart';
import 'package:boat_monitor/charts/line_chart.dart';
import 'package:boat_monitor/charts/line_chart_temp.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/files_model.dart';
import 'package:boat_monitor/models/historics_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';
import 'package:boat_monitor/providers/historics_provider.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/providers/pictures_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../styles/colors.dart';
import 'package:latlong/latlong.dart';

class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  LatLng _position;
  MapController controller = MapController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'journeyPage';
    PicturesBloc().setPictures = null;
    HistoricsBloc().setHistorics = null;
  }

  @override
  Widget build(BuildContext context) {
    JourneyCardArgument _journey = ModalRoute.of(context).settings.arguments;
    HistoricsProvider().getHistorics(context, journeyId: [_journey.journey.id]);
    PicturesProvider().getPictures(context, journeyId: _journey.journey.id);
    double _extraHeight = 0;
    if (MediaQuery.of(context).size.height < 2000) {
      _extraHeight = 50.0;
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('historyPage');
      },
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: gradientAppBar2(
            _journey.journey.boatName, boatIconBlue(25.0, Colors.white), () {
          Navigator.of(context).pushReplacementNamed('historyPage');
        }),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + _extraHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Column(
                  children: [
                    StreamBuilder(
                        stream: HistoricsBloc().historics,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Historics _historics = snapshot.data;
                            if (_historics.historics.length > 0) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: marginExt1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(child: Container()),
                                          Text(
                                            TextLanguage.of(context)
                                                    .travel
                                                    .toUpperCase() +
                                                ' ${_journey.journey.id}',
                                            style: TextStyle(
                                                color: blue1,
                                                fontSize: statusSize,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  AlertsBloc().setAlert =
                                                      Alerts(
                                                          TextLanguage.of(
                                                                  context)
                                                              .downloading,
                                                          "Updating");
                                                  final _resp =
                                                      await JourneyProvider()
                                                          .getFilesZip(context,
                                                              journeyId:
                                                                  _journey
                                                                      .journey
                                                                      .id);
                                                  if (_resp['ok']) {
                                                    AlertsBloc().setAlert =
                                                        Alerts(_resp['message'],
                                                            'Updated');
                                                  } else {
                                                    AlertsBloc().setAlert =
                                                        Alerts(_resp['message'],
                                                            'Error');
                                                  }
                                                },
                                                child: Container(
                                                  child:
                                                      downloadIcon(40.0, blue1),
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
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: marginExt1),
                                      child: Row(
                                        children: [
                                          Text(
                                            TextLanguage.of(context).sail +
                                                ': ${_journey.journey.startUserNames}',
                                            style: TextStyle(
                                                color: blue1,
                                                fontSize: journeySailSize),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            TextLanguage.of(context).arrived +
                                                ': ${_journey.journey.endUserNames}',
                                            style: TextStyle(
                                                color: blue1,
                                                fontSize: journeySailSize),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('weightPage',
                                                arguments: _journey);
                                      },
                                      child: journeyCard(
                                          context,
                                          weightIcon(50.0, blue1),
                                          '  ' +
                                              TextLanguage.of(context)
                                                  .weight
                                                  .toUpperCase() +
                                              '  ',
                                          LineChartBasic(
                                              HistoricsBloc().historicsValue,
                                              1)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                'locationPage',
                                                arguments: JourneyCardArgument(
                                                    journey: _journey.journey,
                                                    historics: HistoricsBloc()
                                                        .historicsValue));
                                      },
                                      child: journeyCard(
                                          context,
                                          locationIcon(50.0, blue1),
                                          TextLanguage.of(context)
                                              .location
                                              .toUpperCase(),
                                          createFlutterMap(
                                              context,
                                              latLongFromString(HistoricsBloc()
                                                  .historicsValue
                                                  .historics
                                                  .last
                                                  .bLocation),
                                              controller,
                                              _historics,
                                              false)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          'temperaturePage',
                                          arguments: JourneyCardArgument(
                                              journey: _journey.journey,
                                              historics: HistoricsBloc()
                                                  .historicsValue),
                                        );
                                      },
                                      child: journeyCard(
                                          context,
                                          temperatureIcon(50.0, blue1),
                                          '    ' +
                                              TextLanguage.of(context)
                                                  .temperature
                                                  .toUpperCase()
                                                  .substring(0, 4) +
                                              '   ',
                                          LineChartTemp(
                                              HistoricsBloc().historicsValue,
                                              1)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                'picturesPage',
                                                arguments: PicturePageArgument(
                                                    journeyCardArgument:
                                                        _journey,
                                                    pictures: PicturesBloc()
                                                        .picturesValue));
                                      },
                                      child: journeyCard(
                                          context,
                                          picturesIcon(50.0, blue1),
                                          TextLanguage.of(context)
                                              .pictures
                                              .toUpperCase(),
                                          StreamBuilder(
                                              stream: PicturesBloc().pictures,
                                              builder: (context,
                                                  AsyncSnapshot<Files>
                                                      snapshot) {
                                                final picturesPreviewList =
                                                    snapshot.data;
                                                if (snapshot.hasData) {
                                                  if (picturesPreviewList
                                                          .files.length ==
                                                      0) {
                                                    return Text(
                                                        TextLanguage.of(context)
                                                            .noData);
                                                  } else {
                                                    return picturesPreview(
                                                        context,
                                                        picturesPreviewList);
                                                  }
                                                } else {
                                                  return circularProgressCustom();
                                                }
                                              })),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    TextLanguage.of(context).noData,
                                    style: TextStyle(
                                        color: blue1, fontSize: correoSize),
                                    textAlign: TextAlign.center,
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: gray1,
                                  ),
                                ],
                              );
                            }
                          } else {
                            return Center(
                              child: circularProgressCustom(),
                            );
                          }
                        }),
                  ],
                )),
                StreamBuilder(
                  stream: AlertsBloc().alert,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        (auth.routeValue == 'journeyPage')) {
                      print('paso por aca');
                      ArgumentBloc().setArgument = JourneyCardArgument(
                          journey: _journey.journey,
                          historics: HistoricsBloc().historicsValue);
                      print(ArgumentBloc().argumentValue);
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => onAfterBuild(_scaffoldKey.currentContext));
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: botomBar(1, context),
      )),
    );
  }
}

Widget journeyCard(
    BuildContext context, Widget icon, String text, Widget child) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: marginExt1),
        height: 135.0,
        width: MediaQuery.of(context).size.width,
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage('assets/cardBorderShadow.png'),
        ),
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: marginExt1),
          height: 135.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(text, style: TextStyle(color: blue1, fontSize: 18.0))
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        //color: blue,
                        height: 110,
                        width: MediaQuery.of(context).size.width -
                            (2 * marginExt1) -
                            160,
                        child: Center(child: child)),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          )),
    ],
  );
}
