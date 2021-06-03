import 'package:boat_monitor/models/boats_model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentBoatBloc {
  dispose() {
    _currentBoatController?.close();
  }

  static final CurrentBoatBloc _singleton = new CurrentBoatBloc._internal();

  factory CurrentBoatBloc() {
    return _singleton;
  }

  CurrentBoatBloc._internal();
  final _currentBoatController = new BehaviorSubject<BoatCardArguments>();
  Stream<BoatCardArguments> get currentBoat => _currentBoatController.stream;
  BoatCardArguments get currentBoatValue => _currentBoatController.value;
  set setCurrentBoat(BoatCardArguments event) =>
      _currentBoatController.add(event);

  final _viewPositionController = new BehaviorSubject<List<bool>>();
  Stream<List<bool>> get viewPosition => _viewPositionController.stream;
  List<bool> get viewPositionValue => _viewPositionController.value;
  set setViewPosition(List<bool> event) => _viewPositionController.add(event);
}
