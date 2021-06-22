import 'package:boat_monitor/models/users_model.dart';
import 'package:boat_monitor/models/journney_model.dart';
import 'package:rxdart/rxdart.dart';

class UsersBloc {
  dispose() {
    _usersController?.close();
  }

  static final UsersBloc _singleton = new UsersBloc._internal();

  factory UsersBloc() {
    return _singleton;
  }

  UsersBloc._internal();
  final _usersController = new BehaviorSubject<Users>();
  Stream<Users> get users => _usersController.stream;
  Users get usersValue => _usersController.value;
  set setUsers(Users event) => _usersController.add(event);
}
