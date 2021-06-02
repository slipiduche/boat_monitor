import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';
import 'package:boat_monitor/charts/line_chart.dart';
import 'package:boat_monitor/charts/line_chart_temp.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/maps/maps.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import 'package:latlong/latlong.dart';
class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();
  String _position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'journeyPage';
  }

  @override
  Widget build(BuildContext context) {
    Journey _journey = ModalRoute.of(context).settings.arguments;
    JourneyProvider().getJourneys();
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          _journey.boatName, boatIconBlue(25.0, Colors.white), () {
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
                      stream: JourneysBloc().journeys,
                      builder: (context, snapshot) {
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
                                      'TRAVEL ${_journey.id}',
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
                                      'Sail: ${_journey.startUserNames}',
                                      style: TextStyle(
                                          color: blue1,
                                          fontSize: journeySailSize),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      'Arrived: ${_journey.endUserNames}',
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
                                    LineChartBasic()),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      'locationPage',
                                      arguments: _journey);
                                },
                                child: journeyCard(
                                    context,
                                    locationIcon(50.0, blue1),
                                    'LOCATION',
                                    createFlutterMap(context, _position.toString())),
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
                                    LineChartTemp()),
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
                      }),
                ],
              )),
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
