import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/generated/l10n.dart';
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
      appBar: gradientAppBar(TextLanguage.of(context).signUp, () {}),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              signUpIcon(100.0, blue1),
              SizedBox(height: 14.0),
              Text(TextLanguage.of(context).signUpMessage),
              SizedBox(height: 40.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt),
                child: formSignUp(context),
              ),
              Container(
                height: 210.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: 50.0,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TextLanguage.of(context).forgot,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text(' ' + TextLanguage.of(context).clicHere,
                            style: TextStyle(
                                color: blue1,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    SizedBox(height: 60)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
