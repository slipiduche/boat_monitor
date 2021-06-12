import 'package:boat_monitor/models/files_model.dart';
import 'package:boat_monitor/providers/parameters.dart';
import 'package:flutter/material.dart';

Widget picture(BuildContext context, String imageUrl) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: NetworkImage(imageUrl),
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: [
      picture(context, Parameters().domain + pictures.files[0].flUrl),
      SizedBox(
        width: 10.0,
      ),
      picture(context, Parameters().domain + pictures.files[1].flUrl),
      //picture(context, urls[2]),
    ],
  );
}
