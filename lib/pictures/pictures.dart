import 'dart:convert';

import 'package:boat_monitor/models/files_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

final _prefs = new UserPreferences();
Widget picture(BuildContext context, String imageUrl, bool compress) {
  Object bodyRequest = {
    "token": _prefs.token,
  };
  if (compress) {
    bodyRequest = {"token": _prefs.token, "compress": compress};
  }
  final _req = jsonEncode(bodyRequest);
  final _req2 = {"body": _req};
  return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: NetworkImage(
          imageUrl,
          headers: _req2,
        ),
        placeholder: AssetImage('assets/no-image.jpg'),
        fit: BoxFit.cover,
      ));
}

Widget picture2(BuildContext context, String imageUrl) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'pictureView', arguments: imageUrl);
    },
    child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          image: NetworkImage(imageUrl),
          placeholder: AssetImage('assets/no-image.jpg'),
          fit: BoxFit.cover,
        )),
  );
}

Widget picturesPreview(BuildContext context, Files pictures) {
  print(Parameters().domain + pictures.files[0].flUrl);
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        picture(context, Parameters().domain + pictures.files[0].flUrl, true),
        SizedBox(
          width: 10.0,
        ),
        picture(context, Parameters().domain + pictures.files[1].flUrl, true),
        //picture(context, urls[2]),
      ],
    ),
  );
}
