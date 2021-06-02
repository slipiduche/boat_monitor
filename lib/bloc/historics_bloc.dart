import 'package:boat_monitor/models/historics_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:rxdart/rxdart.dart';

class HistoricsBloc {
  dispose() {
    _historicsController?.close();
  }

  static final HistoricsBloc _singleton = new HistoricsBloc._internal();

  factory HistoricsBloc() {
    return _singleton;
  }

  HistoricsBloc._internal();
  final _historicsController = new BehaviorSubject<Historics>();
  Stream<Historics> get historics => _historicsController.stream;
  Historics get historicsValue => _historicsController.value;
  set setHistorics(Historics event) => _historicsController.add(event);
}
