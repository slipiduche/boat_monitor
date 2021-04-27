import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

import 'login_widgets.dart';

Widget formSignUp(BuildContext context) {
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        createName(context, ''),
        SizedBox(
          height: marginBox,
        ),
        createEmail(context, ''),
        SizedBox(
          height: marginBox,
        ),
        createPassword(context, ''),
        SizedBox(
          height: marginBox - 20,
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

Widget createName(BuildContext context, _name) {
  return Container(
    padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,

      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).name,
        labelText: TextLanguage.of(context).name,
        suffixIcon: Icon(Icons.email),

        //icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        //setState(() {});
        _name = valor;
      },
    ),
  );
}
