import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/models/historics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

LatLng latLongFromString(String location) {
  double latitude, longitude;
  double grades, minutes, seconds;
  int sign;
  String direction;
  String sLatitude, sLongitude;
  if (location == null) {
    latitude = 0;
    longitude = 0;
  } else {
    sLatitude = location.split(',')[0];
    sLongitude = location.split(',')[1];
    latitude = double.parse(sLatitude);
    longitude = double.parse(sLongitude);
  }

  // sLatitude = location.split(' ')[0];
  // print(sLatitude);
  // grades = double.parse(sLatitude.split('°')[0]);
  // minutes = double.parse(sLatitude.split('°')[1].split("'").first);
  // seconds =
  //     double.parse(sLatitude.split('°')[1].split("'")[1].split('"').first);
  // direction = sLatitude.split('"').last;
  // if (direction == 'N') {
  //   sign = 1;
  // } else {
  //   sign = -1;
  // }
  // print(direction);
  // print(grades);
  // print(minutes);
  // print(seconds);
  // print(sign);
  // latitude = (grades + (minutes / 60) + (seconds / 3600)) * sign;
  // print(latitude);
  // sLongitude = location.split(' ')[1];
  // print(sLongitude);
  // grades = double.parse(sLongitude.split('°')[0]);
  // minutes = double.parse(sLongitude.split('°')[1].split("'").first);
  // seconds =
  //     double.parse(sLongitude.split('°')[1].split("'")[1].split('"').first);
  // direction = sLongitude.split('"').last;
  // if (direction == 'E') {
  //   sign = 1;
  // } else {
  //   sign = -1;
  // }
  // print(direction);
  // //if(){}
  // print(grades);
  // print(minutes);
  // print(seconds);
  // print(sign);
  // longitude = (grades + (minutes / 60) + (seconds / 3600)) * sign;
  // print(longitude);
  return LatLng(latitude, longitude);
}

List<Marker> markers(Historics historics) {
  List<Marker> _markers = [];
  LatLng _position;

  for (var i = 0; i < historics.historics.length; i++) {
    _position = latLongFromString(historics.historics[i].bLocation);
    if (i == 0 && historics.historics.length > 1) {
      _markers.add(Marker(
        width: 10.0,
        height: 10.0,
        point: _position,
        builder: (ctx) => Container(
          child: Icon(
            Icons.circle,
            color: Colors.red,
          ),
        ),
      ));
    }
    if (i == historics.historics.length) {
    } else {
      _markers.add(Marker(
        width: 5.0,
        height: 5.0,
        point: _position,
        builder: (ctx) => Container(
          child: Icon(
            Icons.circle,
            color: Colors.blue,
          ),
        ),
      ));
    }
  }
  return _markers;
}

Widget createFlutterMap(BuildContext context, LatLng position,
    MapController controller, Historics historics) {
  print(position);
  // LatLng location = latLongFromString(position);
  if (position == LatLng(0, 0)) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Center(
            child: Text(TextLanguage.of(context).noData),
          ),
        ));
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
      //margin: EdgeInsets.all(1.0),
      // decoration: BoxDecoration(
      //     border: Border.all(color: blue, style: BorderStyle.solid, width: 2.0),
      //     borderRadius: BorderRadius.circular(5.0)),
      child: FlutterMap(
        mapController: controller,
        options: MapOptions(
          center: position,
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: position,
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
            markers: markers(historics),
          )),
        ],
      ),
    ),
  );
}
