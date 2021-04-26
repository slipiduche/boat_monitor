import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

Widget botonSuperior(String texto, Color color, textColor) {
  return Container(
    //color: colorResaltadoBoton,
    //height: 50.0,
    width: 134.0,
    //margin: EdgeInsets.symmetric(horizontal: 31.0),
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: colorBorderButton,
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
    //color: colorResaltadoBoton,
    //height: 50.0,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: colorBorderButton,
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

Widget formulario(BuildContext context) {
  return Container(
    //color: colorResaltadoBoton,
    //height: 50.0,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 15.0),
    //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: colorBorderButton,
        width: 1.0,
      ),
      //borderRadius: BorderRadius.circular(6.0),
      boxShadow: <BoxShadow>[boxShadow1],
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        crearEmail(''),
        SizedBox(
          height: 30.0,
        ),
        crearPassword(''),
        SizedBox(
          height: 20.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'resetPasswordPage');
          },
          child: Text('¿No recuerdas la contraseña?',
              style: TextStyle(
                  color: blue1, fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        GestureDetector(
            onTap: () async {},
            child: flatButton('Entrar', blue1, Colors.white)),
      ],
    ),
  );
}

Widget crearEmail(_email) {
  return Container(
    padding: EdgeInsets.only(top: 20.0, left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,

      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: 'Correo',
        labelText: 'Correo',
        suffixIcon: Icon(Icons.alternate_email),
        //icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        //setState(() {});
        _email = valor;
      },
    ),
  );
}

Widget crearPassword(_password) {
  return Container(
    padding: EdgeInsets.only(top: 20.0, left: 18.0, right: 18.0),
    child: TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      //keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.lock_open),
        // icon: Icon(Icons.lock)
      ),
      onChanged: (valor) {
        //setState(() {});
        _password = valor;
      },
    ),
  );
}
