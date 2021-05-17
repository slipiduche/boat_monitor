import 'package:rxdart/rxdart.dart';

class HistorySearchBloc {
  dispose() {
    _historySearchController?.close();
  }

  static final HistorySearchBloc _singleton = new HistorySearchBloc._internal();

  factory HistorySearchBloc() {
    return _singleton;
  }

  HistorySearchBloc._internal();
  final _historySearchController = new BehaviorSubject<String>();
  Stream<String> get historySearch => _historySearchController.stream;
  String get historySearchValue => _historySearchController.value;
  set setHistorySearch(String event) => _historySearchController.add(event);
}
