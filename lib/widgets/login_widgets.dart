import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/providers/auth_provider.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:boat_monitor/widgets/alerts.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

Widget upButton(String texto, Color color, textColor) {
  return Container(
    width: 134.0,
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: borderButton,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(4.0),
      boxShadow: <BoxShadow>[boxShadow1],
    ),
    child: Text(texto,
        style:
            TextStyle(color: textColor, fontSize: 20.0, fontFamily: 'Archivo'),
        textAlign: TextAlign.center),
  );
}

Widget flatButton(String texto, Color color, textColor) {
  AuthBloc auth = AuthBloc();
  return Container(
    width: double.infinity,
    //margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 17.0),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: borderButton,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(texto,
        style:
            TextStyle(color: textColor, fontSize: 20.0, fontFamily: 'Archivo'),
        textAlign: TextAlign.center),
  );
}

Widget form(BuildContext context) {
  AuthBloc auth = AuthBloc();
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        createEmail(context),
        SizedBox(
          height: marginBox,
        ),
        createPassword(context),
        SizedBox(
          height: marginBox,
        ),
        StreamBuilder(
            stream: auth.formValidStream,
            builder: (context, snapshot) {
              return GestureDetector(
                  onTap: () {
                    if (snapshot.hasData) _login(context);
                  },
                  child: snapshot.hasData
                      ? flatButton(TextLanguage.of(context).loginButtonText,
                          blue, Colors.white)
                      : flatButton(TextLanguage.of(context).loginButtonText,
                          gray2, Colors.white));
            }),

        //Expanded(child: Container()),
      ],
    ),
  );
}

_login(BuildContext context) {
  _login1(context);
}

_login1(BuildContext context) async {
  AlertsBloc().setAlert =
      Alerts(TextLanguage.of(context).loginButtonText, "Updating");
  //updating(context, TextLanguage.of(context).loginButtonText);
  var _login = await AuthProvider()
      .login(AuthBloc().emailValue, AuthBloc().passwordValue);
  print(_login);
  if (_login["ok"] == true) {
    // Navigator.of(context).pop();

    Navigator.of(context).pushReplacementNamed('managerPage');
    //Navigator.of(context).pushReplacementNamed('supervisorPage');
  } else {
    print(_login["message"]);
    AlertsBloc().setAlert = Alerts(_login["message"], "Error");
    // Navigator.of(context).pop();
    // //errorPopUp(context, _login["message"], () {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushReplacementNamed('homePage');
    //});
  }
}

Widget createEmail(BuildContext context) {
  AuthBloc auth = AuthBloc();
  String _errorText;
  return StreamBuilder(
      stream: auth.email,
      builder: (context, snapshot) {
        if (snapshot.error == 1) {
          _errorText = TextLanguage.of(context).isNotEmail;
        } else {
          _errorText = null;
        }
        return Container(
          //padding: EdgeInsets.only(left: 18.0, right: 18.0),
          child: TextField(
            //autofocus: true,
            //textCapitalization: TextCapitalization.sentences,

            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                hintText: TextLanguage.of(context).email,
                labelText: TextLanguage.of(context).email,
                suffixIcon: Icon(Icons.email),
                //counterText: snapshot.data,
                errorText: _errorText
                //icon: Icon(Icons.email)
                ),
            onChanged: (valor) {
              //setState(() {});
              auth.setEmail = valor;
            },
          ),
        );
      });
}

Widget createPassword(BuildContext context) {
  AuthBloc auth = AuthBloc();
  String _errorText;
  return StreamBuilder(
      stream: auth.password,
      builder: (context, snapshot) {
        if (snapshot.error == 2) {
          _errorText = TextLanguage.of(context).mustHave;
        } else {
          _errorText = null;
        }
        return Container(
          //padding: EdgeInsets.only(left: 18.0, right: 18.0),
          child: TextField(
            //autofocus: true,
            //textCapitalization: TextCapitalization.sentences,
            //keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
              hintText: TextLanguage.of(context).passWord,
              labelText: TextLanguage.of(context).passWord,
              suffixIcon: Icon(Icons.vpn_key_rounded),
              //counterText: snapshot.data,
              errorText: _errorText,
              // icon: Icon(Icons.lock)
            ),
            onChanged: (valor) {
              //setState(() {});

              auth.setPassword = valor;
            },
          ),
        );
      });
}
