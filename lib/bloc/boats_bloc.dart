import 'package:boat_monitor/models/boats_model.dart';
import 'package:rxdart/rxdart.dart';

class BoatsBloc {
  dispose() {
    _boatsController?.close();
  }

  static final BoatsBloc _singleton = new BoatsBloc._internal();

  factory BoatsBloc() {
    return _singleton;
  }

  BoatsBloc._internal();
  final _boatsController = new BehaviorSubject<List<BoatData>>();
  Stream<List<BoatData>> get boats => _boatsController.stream;
  List<BoatData> get boatsValue => _boatsController.value;
  set setBoats(List<BoatData> event) => _boatsController.add(event);

  final _checkController = new BehaviorSubject<int>();
  Stream<int> get check => _checkController.stream;
  int get checkValue => _checkController.value;
  set setCheck(int event) => _checkController.add(event);
}
