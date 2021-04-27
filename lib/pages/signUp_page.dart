import 'dart:ui';

import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/Signup_widgets.dart';
import 'package:boat_monitor/widgets/login_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar(TextLanguage.of(context).signUp, () {
        Navigator.of(context).pushReplacementNamed('loginPage');
      }),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              signUpIcon(100.0, blue1),
              SizedBox(height: 14.0),
              Text(
                TextLanguage.of(context).signUpMessage,
                style: TextStyle(
                    color: blue1,
                    fontSize: messageTitle,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt),
                child: FormSignup(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}