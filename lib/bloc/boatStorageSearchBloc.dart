import 'package:rxdart/rxdart.dart';

class BoatStorageSearchBloc {
  dispose() {
    _boatStorageSearchController?.close();
  }

  static final BoatStorageSearchBloc _singleton =
      new BoatStorageSearchBloc._internal();

  factory BoatStorageSearchBloc() {
    return _singleton;
  }

  BoatStorageSearchBloc._internal();
  final _boatStorageSearchController = new BehaviorSubject<String>();
  Stream<String> get boatStorageSearch => _boatStorageSearchController.stream;
  String get boatStorageSearchValue => _boatStorageSearchController.value;
  set setBoatStorageSearch(String event) =>
      _boatStorageSearchController.add(event);
}
