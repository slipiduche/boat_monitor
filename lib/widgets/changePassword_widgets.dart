import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/providers/auth_provider.dart';
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
        StreamBuilder(
            stream: AuthBloc().newPasswordValidStream,
            builder: (context, snapshot) {
              return GestureDetector(
                  onTap: () async {
                    if (snapshot.hasData) change(context);
                  },
                  child: snapshot.hasData
                      ? flatButton(
                          TextLanguage.of(context).resetPasswordButtonText,
                          blue,
                          Colors.white)
                      : flatButton(
                          TextLanguage.of(context).resetPasswordButtonText,
                          gray2,
                          Colors.white));
            }),

        //Expanded(child: Container()),
      ],
    ),
  );
}

change(BuildContext context) {
  print('cambiando');
  change1(context);
}

change1(BuildContext context) async {
  AlertsBloc().setAlert = Alerts(TextLanguage.of(context).updating, "Updating");
  //updating(context, TextLanguage.of(context).loginButtonText);
  var _change =
      await AuthProvider().passwordChange(AuthBloc().newPasswordValue);
  print(_change);
  if (_change["ok"] == true) {
    // Navigator.of(context).pop();

    Navigator.of(context).pushReplacementNamed('loginPage');
  } else {
    print(_change["message"]);
    AlertsBloc().setAlert = Alerts(_change["message"], "Error");
    // Navigator.of(context).pop();
    // //errorPopUp(context, _login["message"], () {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushReplacementNamed('homePage');
    //});
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
        AuthBloc().setNewPassword = valor;
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
        AuthBloc().setPassword = valor;
      },
    ),
  );
}
