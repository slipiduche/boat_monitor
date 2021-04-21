import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

PreferredSizeWidget gradientAppBar(String title, Function onBackPressed) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: Container(
      height: 50.0,
      width: double.infinity,
      decoration:
          BoxDecoration(gradient: blueGradient1, boxShadow: [boxShadow1]),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: titleBarSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: blue,
            ),
            onPressed: onBackPressed),
      ]),
    ),
  );
}
