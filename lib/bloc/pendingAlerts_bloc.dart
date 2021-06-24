import 'package:boat_monitor/models/pendingAlerts_model.dart';
import 'package:rxdart/rxdart.dart';

class PendingAlertsBloc {
  dispose() {
    _pendingAlertsController?.close();
  }

  static final PendingAlertsBloc _singleton = new PendingAlertsBloc._internal();

  factory PendingAlertsBloc() {
    return _singleton;
  }

  PendingAlertsBloc._internal();
  final _pendingAlertsController = new BehaviorSubject<List<PendingAlert>>();
  Stream<List<PendingAlert>> get pendingAlerts =>
      _pendingAlertsController.stream;
  List<PendingAlert> get pendingAlertsValue => _pendingAlertsController.value;
  set setPendingAlerts(List<PendingAlert> event) =>
      _pendingAlertsController.add(event);

  final _checkController = new BehaviorSubject<int>();
  Stream<int> get check => _checkController.stream;
  int get checkValue => _checkController.value;
  set setCheck(int event) => _checkController.add(event);
}
