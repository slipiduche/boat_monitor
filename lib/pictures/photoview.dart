import 'dart:convert';

import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PictureView extends StatelessWidget {
  PictureView({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.basePosition = Alignment.center,
    this.filterQuality = FilterQuality.none,
    this.disableGestures,
    this.errorBuilder,
  });

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;
  final FilterQuality filterQuality;
  final bool disableGestures;
  final ImageErrorWidgetBuilder errorBuilder;
  final _prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    Object bodyRequest = {
      "token": _prefs.token,
    };

    final _req = jsonEncode(bodyRequest);
    final _req2 = {"body": _req};
    String _url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: NetworkImage(_url, headers: _req2),
          loadingBuilder: (context, event) {
            return Image.asset('assets/no-image.jpg');
          },
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          initialScale: initialScale,
          basePosition: basePosition,
          filterQuality: filterQuality,
          disableGestures: disableGestures,
          errorBuilder: errorBuilder,
        ),
      ),
    );
  }
}
