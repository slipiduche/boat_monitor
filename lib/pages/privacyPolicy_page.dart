import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/Login_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: gradientAppBar(TextLanguage.of(context).privacyPolicy, () {
        Navigator.of(context).pushReplacementNamed('signUpPage');
      }),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: marginExt, vertical: marginExt),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(TextLanguage.of(context).privacyPolicyText,
                  style: TextStyle(
                      color: blue1,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify)
            ],
          ),
        ),
      ),
    ));
  }
}
