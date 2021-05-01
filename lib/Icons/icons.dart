import 'package:flutter/material.dart';

Widget boatIconBlue(size, color) {
  return Image(
    image: AssetImage('assets/boatIconBlue.png'),
    color: color,
    height: size,
  );
}

Widget signUpIcon(size, color) {
  return Image(
    image: AssetImage('assets/signUpIcon.png'),
    //color: color,
    height: size,
  );
}

Widget nameIcon(size) {
  return ImageIcon(
    AssetImage('assets/nameIcon.png'),
    //color: color,
  );
}

Widget managerIcon(size) {
  return Image(
    image: AssetImage('assets/managerIcon.png'),
    height: size,
    //color: color,
  );
}
