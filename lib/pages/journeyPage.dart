import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';

import 'package:boat_monitor/bloc/journeys_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/providers/journeys_provider.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

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
                height: 20.0,
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
                                    Text('TRAVEL ${_journey.id}',style: TextStyle(color:blue1,fontSize:statusSize,fontWeight: FontWeight.bold),),
                                    Expanded(child: 
                                    Row(
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
                              SizedBox(
                                height: 10.0,
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

Widget makeTravelList(BuildContext context, List<Journey> journeys) {
  return Container(
    child: ListView.builder(
      itemCount: journeys.length,
      itemBuilder: (BuildContext context, int index) {
        print(journeys[index]);
        return _travelCard(context, journeys[index]);
      },
    ),
  );
}

Widget _travelCard(BuildContext context, Journey journey) {
  return Container(
      //height: 150,
      //margin: EdgeInsets.symmetric(horizontal: marginExt1, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: gray1)),
        //borderRadius: BorderRadius.circular(5.0)
      ),
      child: Stack(children: [
        Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.id}',
                      textAlign: TextAlign.center,
                      style: TextStyle(

                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 20,
                    child: Text(
                      '${journey.ini}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 20,
                    child: Text(
                      '${journey.ed}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 30,
                    child: Text(
                      '${journey.boatName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5 - 10,
                    child: Text(
                      '${journey.startUserNames}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          //color: blue1,
                          //fontWeight: FontWeight.bold,
                          fontSize: privacyPolicySize + 2.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ]));
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
