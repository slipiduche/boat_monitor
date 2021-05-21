import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

Widget createFlutterMap(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
      //margin: EdgeInsets.all(1.0),
      // decoration: BoxDecoration(
      //     border: Border.all(color: blue, style: BorderStyle.solid, width: 2.0),
      //     borderRadius: BorderRadius.circular(5.0)),
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(10.85505081830189, -68.29910433238481),
          zoom: 13.0,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: LatLng(10.85505081830189, -68.29910433238481),
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
