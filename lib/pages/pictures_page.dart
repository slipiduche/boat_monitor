import 'dart:ui';
import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';

import 'package:boat_monitor/generated/l10n.dart';

import 'package:boat_monitor/models/journney_model.dart';
import 'package:boat_monitor/pictures/pictures.dart';

import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class PicturesPage extends StatefulWidget {
  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  UserPreferences _prefs = UserPreferences();
  AuthBloc auth = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
    AuthBloc().setRoute = 'picturesPage';
  }

  @override
  Widget build(BuildContext context) {
    Journey _pictures = ModalRoute.of(context).settings.arguments;

    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar2(
          _pictures.boatName, boatIconBlue(25.0, Colors.white), () {
        Navigator.of(context)
            .pushReplacementNamed('journeyPage', arguments: _pictures);
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
                              'TRAVEL ${_pictures.id}',
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
                      Text(
                        'PICTURES',
                        style: TextStyle(
                          color: blue1,
                          fontSize: correoSize,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
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
