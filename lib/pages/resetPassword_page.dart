import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:boat_monitor/widgets/login_widgets.dart';
import 'package:boat_monitor/widgets/ResetPassword_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  AuthBloc auth = AuthBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar(TextLanguage.of(context).passwordRecovery, () {
        Navigator.of(context).pushReplacementNamed('loginPage');
      }),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              ImageIcon(
                AssetImage('assets/keyIcon.png'),
                size: 100.0,
                color: blue1,
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt),
                child: Text(TextLanguage.of(context).recoveryText,
                    style: TextStyle(
                        color: blue1,
                        fontSize: messageTitle,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt),
                child: formReset(context),
              ),
              SizedBox(height: 20.0),
              StreamBuilder(
                stream: AlertsBloc().alert,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => onAfterBuild(context));
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
