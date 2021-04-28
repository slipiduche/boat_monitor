import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/providers/auth_provider.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

import 'login_widgets.dart';

Widget formReset(BuildContext context) {
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
        StreamBuilder(
            stream: auth.email,
            builder: (context, snapshot) {
              return GestureDetector(
                  onTap: () {
                    if (snapshot.hasData) _reset(context);
                  },
                  child: snapshot.hasData
                      ? flatButton(TextLanguage.of(context).passwordRecovery,
                          blue, Colors.white)
                      : flatButton(TextLanguage.of(context).passwordRecovery,
                          gray2, Colors.white));
            }),

        //Expanded(child: Container()),
      ],
    ),
  );
}

_reset(BuildContext context) {
  _reset1(context);
}

_reset1(BuildContext context) async {
  AlertsBloc().setAlert =
      Alerts(TextLanguage.of(context).passwordRecovery, "Updating");
  print(AuthBloc().emailValue);
  var _reset = await AuthProvider().recovery(AuthBloc().emailValue);
  if (_reset["ok"] == true) {
    AlertsBloc().setAlert = Alerts(_reset["message"], "Updated");
  } else {
    print(_reset["message"]);
    AlertsBloc().setAlert = Alerts(_reset["message"], "Error");
  }
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
