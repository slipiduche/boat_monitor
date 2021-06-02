import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

LatLng latLongFromString(String location) {
  double latitude, longitude;
  double grades, minutes, seconds;
  int sign;
  String direction;
  String sLatitude, sLongitude;
  sLatitude = location.split(' ')[0];
  print(sLatitude);
  grades = double.parse(sLatitude.split('°')[0]);
  minutes = double.parse(sLatitude.split('°')[1].split("'").first);
  seconds =
      double.parse(sLatitude.split('°')[1].split("'")[1].split('"').first);
  direction = sLatitude.split('"').last;
  if (direction == 'N') {
    sign = 1;
  } else {
    sign = -1;
  }
  print(direction);
  print(grades);
  print(minutes);
  print(seconds);
  print(sign);
  latitude = (grades + (minutes / 60) + (seconds / 3600)) * sign;
  print(latitude);
  sLongitude = location.split(' ')[1];
  print(sLongitude);
  grades = double.parse(sLongitude.split('°')[0]);
  minutes = double.parse(sLongitude.split('°')[1].split("'").first);
  seconds =
      double.parse(sLongitude.split('°')[1].split("'")[1].split('"').first);
  direction = sLongitude.split('"').last;
  if (direction == 'E') {
    sign = 1;
  } else {
    sign = -1;
  }
  print(direction);
  //if(){}
  print(grades);
  print(minutes);
  print(seconds);
  print(sign);
  longitude = (grades + (minutes / 60) + (seconds / 3600)) * sign;
  print(longitude);
  return LatLng(latitude, longitude);
}

Widget createFlutterMap(BuildContext context, String position) {
  print(position);
  LatLng location = latLongFromString(position);
  return ClipRRect(
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
      //margin: EdgeInsets.all(1.0),
      // decoration: BoxDecoration(
      //     border: Border.all(color: blue, style: BorderStyle.solid, width: 2.0),
      //     borderRadius: BorderRadius.circular(5.0)),
      child: FlutterMap(
        options: MapOptions(
          center: location,
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: location,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
        children: <Widget>[
          TileLayerWidget(
              options: TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'])),
          MarkerLayerWidget(
              options: MarkerLayerOptions(
            markers: [
              // Marker(
              //   width: 80.0,
              //   height: 80.0,
              //   point: LatLng(10.85505081830189, -68.29910433238481),
              //   builder: (ctx) => Container(
              //     child: FlutterLogo(),
              //   ),
              // ),
            ],
          )),
        ],
      ),
    ),
  );
}
