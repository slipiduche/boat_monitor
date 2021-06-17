import 'package:rxdart/rxdart.dart';

class ArgumentBloc {
  dispose() {
    _argumentController?.close();
  }

  static final ArgumentBloc _singleton = new ArgumentBloc._internal();

  factory ArgumentBloc() {
    return _singleton;
  }

  ArgumentBloc._internal();
  final _argumentController = new BehaviorSubject<dynamic>();
  Stream<dynamic> get argument => _argumentController.stream;
  dynamic get argumentValue => _argumentController.value;
  set setArgument(dynamic event) => _argumentController.add(event);
}
