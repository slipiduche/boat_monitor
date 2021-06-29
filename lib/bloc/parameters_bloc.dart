import 'package:boat_monitor/models/parameters_model.dart';

import 'package:rxdart/rxdart.dart';

class ParametersBloc {
  dispose() {
    _parametersController?.close();
  }

  static final ParametersBloc _singleton = new ParametersBloc._internal();

  factory ParametersBloc() {
    return _singleton;
  }

  ParametersBloc._internal();
  final _parametersController = new BehaviorSubject<UserParameters>();
  Stream<UserParameters> get parameters => _parametersController.stream;
  UserParameters get parametersValue => _parametersController.value;
  set setParameters(UserParameters event) => _parametersController.add(event);
}
