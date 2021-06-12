import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/changePassword_widgets.dart';

import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/colors.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  AuthBloc auth = AuthBloc();
  final _prefs = new UserPreferences();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('managerPage');
      },
      child: SafeArea(
          child: Scaffold(
        appBar: gradientAppBar(TextLanguage.of(context).newPassword, () {
          Navigator.of(context).pushReplacementNamed('managerPage');
        }),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: marginSupicon),
                SizedBox(height: 73.0),
                Text(_prefs.email,
                    style: TextStyle(
                        color: blue1,
                        fontSize: correoSize,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: 30.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginExt),
                  child: formChange(context),
                ),
                SizedBox(height: 20.0),
                StreamBuilder(
                  stream: AlertsBloc().alert,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => onAfterBuild(context, 1));
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
