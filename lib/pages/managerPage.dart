import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
//import 'package:boat_monitor/widgets/manager_widgets.dart';
import 'package:boat_monitor/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
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
      //appBar: gradientAppBar(TextLanguage.of(context).managerButtonText, () {}),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginSupicon),
              managerIcon(100.0),
              SizedBox(height: 73.0),
              SizedBox(height: 20.0),
              StreamBuilder(
                  stream: auth.formValidStream,
                  builder: (context, snapshot) {
                    double _height = 260;
                    if (snapshot.hasError) {
                      _height = 200.0;
                    } else {
                      _height = 260.0;
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: marginExt),
                      height: _height,
                      
                    );
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
