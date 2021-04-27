import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/changePassword_widgets.dart';

import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar(TextLanguage.of(context).newPassword, () {
        Navigator.of(context).pushReplacementNamed('loginPage');
      }),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              SizedBox(height: 73.0),
              Text('Correo@.com',
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
            ],
          ),
        ),
      ),
    ));
  }
}