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

Widget picturesPreview(BuildContext context, List<String> urls) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: [
      picture(context, urls[0]),
      SizedBox(width: 10.0,),
      picture(context, urls[1]),
      //picture(context, urls[2]),
    ],
  );
}
