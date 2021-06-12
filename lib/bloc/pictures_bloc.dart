import 'package:boat_monitor/models/files_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:rxdart/rxdart.dart';

class PicturesBloc {
  dispose() {
    _picturesController?.close();
  }

  static final PicturesBloc _singleton = new PicturesBloc._internal();

  factory PicturesBloc() {
    return _singleton;
  }

  PicturesBloc._internal();
  final _picturesController = new BehaviorSubject<Files>();
  Stream<Files> get pictures => _picturesController.stream;
  Files get picturesValue => _picturesController.value;
  set setPictures(Files event) => _picturesController.add(event);
}
