import 'package:boat_monitor/models/pendingApprovals_model.dart';
import 'package:rxdart/rxdart.dart';

class PendingApprovalsBloc {
  dispose() {
    _pendingApprovalsController?.close();
  }

  static final PendingApprovalsBloc _singleton =
      new PendingApprovalsBloc._internal();

  factory PendingApprovalsBloc() {
    return _singleton;
  }

  PendingApprovalsBloc._internal();
  final _pendingApprovalsController = new BehaviorSubject<PendingApprovals>();
  Stream<PendingApprovals> get pendingApprovals =>
      _pendingApprovalsController.stream;
  PendingApprovals get alertApprovalsValue => _pendingApprovalsController.value;
  set setPendingApprovals(PendingApprovals event) =>
      _pendingApprovalsController.add(event);
  final _checkController = new BehaviorSubject<int>();
  Stream<int> get check => _checkController.stream;
  int get checkValue => _checkController.value;
  set setCheck(int event) => _checkController.add(event);
}
