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
  final _pendingAlertsController = new BehaviorSubject<List<PendingAlerts>>();
  Stream<List<PendingAlerts>> get pendingAlerts =>
      _pendingAlertsController.stream;
  List<PendingAlerts> get alertAlertsValue => _pendingAlertsController.value;
  set setPendingAlerts(List<PendingAlerts> event) =>
      _pendingAlertsController.add(event);
}
