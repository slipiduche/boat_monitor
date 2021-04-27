import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

import 'login_widgets.dart';

Widget formChange(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _createNewPassword(context, ''),
        SizedBox(
          height: marginBox,
        ),
        _createConfirmPassword(context, ''),
        SizedBox(
          height: marginBox,
        ),
        GestureDetector(
            onTap: () async {},
            child: flatButton(TextLanguage.of(context).resetPasswordButtonText,
                blue, Colors.white)),

        //Expanded(child: Container()),
      ],
    ),
  );
}

Widget _createConfirmPassword(BuildContext context, _password) {
  return Container(
    //padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).confirmPassword,
        labelText: TextLanguage.of(context).confirmPassword,
        //suffixIcon: Icon(Icons.vpn_key_rounded),
        // icon: Icon(Icons.lock)
      ),
      onChanged: (valor) {
        //setState(() {});
        _password = valor;
      },
    ),
  );
}

Widget _createNewPassword(BuildContext context, _password) {
  return Container(
    //padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).newPassword,
        labelText: TextLanguage.of(context).newPassword,
        //suffixIcon: Icon(Icons.vpn_key_rounded),
        // icon: Icon(Icons.lock)
      ),
      onChanged: (valor) {
        //setState(() {});
        _password = valor;
      },
    ),
  );
}