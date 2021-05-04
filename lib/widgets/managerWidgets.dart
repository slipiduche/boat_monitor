import 'package:boat_monitor/Icons/icons.dart';
import 'package:boat_monitor/styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

Widget managerOption(
    String option, Color optioColor,Widget leading, Function ontap, int itemcount) {
  return Builder(builder: (context) {
    if (itemcount > 0) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: marginExt),
        onTap: () {
          ontap();
        },
        leading: leading,
        title: Text(
          option,
          style: TextStyle(color: optioColor, fontSize: messageTitle,fontWeight: FontWeight.w400),
        ),
        trailing: Text(
          itemcount.toString(),
          style: TextStyle(color: redAlert, fontSize: messageTitle,fontWeight: FontWeight.w400),
        ),
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: marginExt),
        
        onTap: () {
          ontap();
        },
        leading: leading,
        title: Text(
          option,
          style: TextStyle(color: optioColor, fontSize: messageTitle,fontWeight: FontWeight.w400),
        ),
      );
    }
  });
}
