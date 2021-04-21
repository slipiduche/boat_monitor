import 'package:flutter/material.dart';

final LinearGradient whiteGradient = LinearGradient(
  colors: [Colors.white60, Color.fromRGBO(255, 255, 255, 0)],
  stops: [0.099, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
final Color blue = Color.fromRGBO(73, 185, 219, 1.0);
final Color blue1 = Color.fromRGBO(0, 56, 112, 1.0);
final Color blue0_1 = Color.fromRGBO(73, 185, 219, 0.5);
final Color blue1_2 = Color.fromRGBO(0, 56, 112, 0.2);
final Color blue2 = Color.fromRGBO(61, 169, 216, 0.6);
final Color blue3 = Color.fromRGBO(0, 56, 112, 1.0);
final Color blueUnselect = Color.fromRGBO(69, 108, 147, 1.0);

final LinearGradient blueGradient1 = LinearGradient(
  colors: [blue1, blue],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
final LinearGradient blueGradient2 = LinearGradient(
  colors: [blue0_1, blue1_2],
  stops: [1.0, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
final LinearGradient blueGradient3 = LinearGradient(
  colors: [blue, blue1],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
final Color gray = Color.fromRGBO(229, 229, 229, 1.0);
final Color gray1 = Color.fromRGBO(142, 142, 142, 1.0);
final Color gray2 = Color.fromRGBO(197, 197, 197, 1.0);
final Color gray3 = Color.fromRGBO(169, 169, 169, 1.0);
final LinearGradient gradient2 = LinearGradient(
  colors: [gray1, gray3, gray2, gray],
  stops: [0.0, 0.651, 0.9999, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
final Color colorShadow = Color.fromRGBO(0, 0, 0, 0.25);
final BoxShadow boxShadow1 = BoxShadow(
    color: colorShadow,
    blurRadius: 4.0,
    spreadRadius: 0.0,
    offset: Offset(0, 4.0));
