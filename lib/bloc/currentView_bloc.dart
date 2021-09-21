import 'package:rxdart/rxdart.dart';
import 'package:latlong/latlong.dart';

class CurrentViewBloc {
  dispose() {
    _currentViewPosition?.close();
  }

  static final CurrentViewBloc _singleton = new CurrentViewBloc._internal();

  factory CurrentViewBloc() {
    return _singleton;
  }

  CurrentViewBloc._internal();
  final _currentViewPosition = new BehaviorSubject<LatLng>();
  Stream<LatLng> get currentViewPosition => _currentViewPosition.stream;
  LatLng get currentViewPositionValue => _currentViewPosition.value;
  set setcurrentViewPosition(LatLng event) => _currentViewPosition.add(event);
  final _currentViewZoomController = new BehaviorSubject<double>();
  Stream<double> get currentViewZoom => _currentViewZoomController.stream;
  double get currentViewZoomValue => _currentViewZoomController.value;
  set setcurrentViewZoom(double event) => _currentViewZoomController.add(event);
}
