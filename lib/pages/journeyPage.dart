import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/historics_bloc.dart';
import 'package:boat_monitor/charts/line_chart.dart';
import 'package:boat_monitor/charts/line_chart_temp.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';
import 'package:boat_monitor/providers/historics_provider.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    JourneyCardArgument _journey = ModalRoute.of(context).settings.arguments;
    //JourneyProvider().getJourneys();
    HistoricsProvider().getHistorics(journeyId: _journey.journey.id);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: gradientAppBar2(
          _journey.journey.boatName, boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context).pushReplacementNamed('historyPage');
      }),
      body: SingleChildScrollView(
        child: Container(
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
                  StreamBuilder(
                      stream: HistoricsBloc().historics,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // controller.move(
                          //     latLongFromString(HistoricsBloc()
                          //         .historicsValue
                          //         .historics
                          //         .last
                          //         .bLocation),
                          //     13.0);
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: marginExt1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(child: Container()),
                                      Text(
                                        'TRAVEL ${_journey.journey.id}',
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
                                              AlertsBloc().setAlert = Alerts(
                                                  'Downloading', "Updating");
                                              final _resp =
                                                  await JourneyProvider()
                                                      .getFilesZip(
                                                          journeyId: _journey
                                                              .journey.id);
                                              if (_resp['ok']) {
                                                AlertsBloc().setAlert = Alerts(
                                                    _resp['message'],
                                                    'Updated');
                                              } else {
                                                AlertsBloc().setAlert = Alerts(
                                                    _resp['message'], 'Error');
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
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: marginExt1),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Sail: ${_journey.journey.startUserNames}',
                                        style: TextStyle(
                                            color: blue1,
                                            fontSize: journeySailSize),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        'Arrived: ${_journey.journey.endUserNames}',
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
                                    Navigator.of(context).pushReplacementNamed(
                                        'weightPage',
                                        arguments: _journey);
                                  },
                                  child: journeyCard(
                                      context,
                                      weightIcon(50.0, blue1),
                                      'WEIGHT',
                                      LineChartBasic(
                                          HistoricsBloc().historicsValue)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        'locationPage',
                                        arguments: JourneyCardArgument(
                                            journey: _journey.journey,
                                            historics: HistoricsBloc()
                                                .historicsValue));
                                  },
                                  child: journeyCard(
                                      context,
                                      locationIcon(50.0, blue1),
                                      'LOCATION',
                                      createFlutterMap(
                                          context,
                                          latLongFromString(HistoricsBloc()
                                              .historicsValue
                                              .historics
                                              .last
                                              .bLocation),
                                          controller)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        'temperaturePage',
                                        arguments: _journey);
                                  },
                                  child: journeyCard(
                                      context,
                                      temperatureIcon(50.0, blue1),
                                      'TEMPERTURE',
                                      LineChartTemp(
                                          HistoricsBloc().historicsValue)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        'picturesPage',
                                        arguments: _journey);
                                  },
                                  child: journeyCard(
                                      context,
                                      picturesIcon(50.0, blue1),
                                      'PICTURES',
                                      picturesPreview(context, [
                                        'https://picsum.photos/id/1011/200/300',
                                        'https://picsum.photos/id/1011/200/300',
                                        'https://picsum.photos/id/1011/200/300'
                                      ])),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              )),
              StreamBuilder(
                stream: AlertsBloc().alert,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      onAfterBuild(
                          _scaffoldKey.currentContext,
                          JourneyCardArgument(
                              journey: _journey.journey,
                              historics: HistoricsBloc().historicsValue)));
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: botomBar(1, context),
    ));
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
                  Text(text, style: TextStyle(color: blue1, fontSize: 20.0))
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
