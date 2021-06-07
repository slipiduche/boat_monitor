import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HistorySearch {
  String content;
  DateTimeRange range;
  HistorySearch({this.content, this.range});
}

class HistorySearchBloc {
  dispose() {
    _historySearchController?.close();
  }

  static final HistorySearchBloc _singleton = new HistorySearchBloc._internal();

  factory HistorySearchBloc() {
    return _singleton;
  }

  HistorySearchBloc._internal();
  final _historySearchController = new BehaviorSubject<HistorySearch>();
  Stream<HistorySearch> get historySearch => _historySearchController.stream;
  HistorySearch get historySearchValue => _historySearchController.value;
  set setHistorySearch(HistorySearch event) =>
      _historySearchController.add(event);
}
