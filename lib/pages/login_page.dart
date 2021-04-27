import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/login_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar(TextLanguage.of(context).loginButtonText, () {}),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              boatIconBlue(100.0, blue1),
              SizedBox(height: 73.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: marginExt),
                child: form(context),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'signUpPage');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(TextLanguage.of(context).dontHaveAccount,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          GestureDetector(
                            child: Text(
                                ' ' + TextLanguage.of(context).signupHere,
                                style: TextStyle(
                                    color: blue1,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
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
