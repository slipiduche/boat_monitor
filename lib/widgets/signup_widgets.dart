import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/name_icon_icons.dart';
import 'package:boat_monitor/providers/auth_provider.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

import 'login_widgets.dart';

class FormSignup extends StatefulWidget {
  FormSignup({Key key}) : super(key: key);

  @override
  _FormSignupState createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  bool _checkState = false;
  @override
  Widget build(BuildContext context) {
    return _formSignUp(context);
  }

  Widget _formSignUp(BuildContext context) {
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
            height: marginBox,
          ),
          Container(
            //Sheight: 110.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        splashRadius: 4.0,
                        activeColor: blue1,
                        value: _checkState,
                        onChanged: (value) {
                          _checkState = value;
                          setState(() {});
                        }),
                    Text(TextLanguage.of(context).iRead,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: privacyPolicySize,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('privacyPage');
                      },
                      child: Text(' ' + TextLanguage.of(context).privacyPolicy,
                          style: TextStyle(
                              color: blue1,
                              fontSize: privacyPolicySize,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                SizedBox(
                  height: marginBox - 20,
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () async {
                await AuthProvider().signUp(
                    'alejandro', 'alejandrocamacaro91@gmail.com', '20075194');
              },
              child: flatButton(
                  TextLanguage.of(context).signUp, blue, Colors.white)),

          //Expanded(child: Container()),
        ],
      ),
    );
  }
}

Widget createName(BuildContext context, _name) {
  return Container(
    //padding: EdgeInsets.only(left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,

      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: TextLanguage.of(context).name,
        labelText: TextLanguage.of(context).name,
        suffixIcon: Icon(NameIcon.nameicon),

        //icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        //setState(() {});
        _name = valor;
      },
    ),
  );
}
