import 'package:rxdart/rxdart.dart';

class HomeSearchBloc {
  dispose() {
    _homeSearchController?.close();
  }

  static final HomeSearchBloc _singleton = new HomeSearchBloc._internal();

  factory HomeSearchBloc() {
    return _singleton;
  }

  HomeSearchBloc._internal();
  final _homeSearchController = new BehaviorSubject<String>();
  Stream<String> get homeSearch => _homeSearchController.stream;
  String get homeSearchValue => _homeSearchController.value;
  set setHomeSearch(String event) => _homeSearchController.add(event);
}
