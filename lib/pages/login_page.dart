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
          appBar: AppBar(
            
          ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(gradient: blueGradient1),
            ),
            Text(
              'Here will start your project',
              style: TextStyle(fontSize: 40.0),
            ),
          ],
        ),
      ),
    ));
  }
}
