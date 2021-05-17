import 'package:boat_monitor/models/journney_model.dart';
import 'package:rxdart/rxdart.dart';

class JourneysBloc {
  dispose() {
    _journeysController?.close();
  }

  static final JourneysBloc _singleton = new JourneysBloc._internal();

  factory JourneysBloc() {
    return _singleton;
  }

  JourneysBloc._internal();
  final _journeysController = new BehaviorSubject<List<Journey>>();
  Stream<List<Journey>> get journeys => _journeysController.stream;
  List<Journey> get journeysValue => _journeysController.value;
  set setJourneys(List<Journey> event) => _journeysController.add(event);

  final _checkController = new BehaviorSubject<int>();
  Stream<int> get check => _checkController.stream;
  int get checkValue => _checkController.value;
  set setCheck(int event) => _checkController.add(event);

  final _boatNameController = new BehaviorSubject<String>();
  Stream<String> get boatName => _boatNameController.stream;
  String get boatNameValue => _boatNameController.value;
  set setBoatName(String event) => _boatNameController.add(event);
}
