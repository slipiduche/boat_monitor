import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
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
  return Container(
    width: double.infinity,
    //margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
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
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        createEmail(context, ''),
        SizedBox(
          height: marginBox,
        ),
        createPassword(context, ''),
        SizedBox(
          height: marginBox ,
        ),
        GestureDetector(
            onTap: () async {},
            child: flatButton(
                TextLanguage.of(context).loginButtonText, blue, Colors.white)),

        //Expanded(child: Container()),
      ],
    ),
  );
}

Widget createEmail(BuildContext context, _email) {
  return Container(
    //padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,

      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).email,
        labelText: TextLanguage.of(context).email,
        suffixIcon: Icon(Icons.email),

        //icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        //setState(() {});
        _email = valor;
      },
    ),
  );
}

Widget createPassword(BuildContext context, _password) {
  return Container(
    //padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).passWord,
        labelText: TextLanguage.of(context).passWord,
        suffixIcon: Icon(Icons.vpn_key_rounded),
        // icon: Icon(Icons.lock)
      ),
      onChanged: (valor) {
        //setState(() {});
        _password = valor;
      },
    ),
  );
}
