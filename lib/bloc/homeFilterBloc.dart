import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeFilterBloc {
  dispose() {
    _homeFilterController?.close();
  }

  static final HomeFilterBloc _singleton = new HomeFilterBloc._internal();

  factory HomeFilterBloc() {
    return _singleton;
  }

  HomeFilterBloc._internal();

  final _homeFilterController = new BehaviorSubject<String>();
  Stream<String> get homeFilter => _homeFilterController.stream;
  String get homeFilterValue => _homeFilterController.value;
  set sethomeFilter(String event) => _homeFilterController.add(event);
  deletehomeFilter() {
    _homeFilterController.add(null);
  }
}
