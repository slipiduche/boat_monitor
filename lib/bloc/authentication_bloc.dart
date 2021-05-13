import 'dart:async';
import 'package:boat_monitor/bloc/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc with Validators {
  dispose() {
    _emailController?.close();
    _nameController?.close();
    _passwordController?.close();
  }

  static final AuthBloc _singleton = new AuthBloc._internal();

  factory AuthBloc() {
    return _singleton;
  }

  AuthBloc._internal();

  final _emailController = new BehaviorSubject<String>();
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  String get emailValue => _emailController.value;
  set setEmail(String event) => _emailController.add(event);
  deleteEmail() {
    _emailController.add(null);
  }

  final _passwordController = new BehaviorSubject<String>();
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  String get passwordValue => _passwordController.value;
  set setPassword(String event) => _passwordController.add(event);
  deletePassword() {
    _passwordController.add(null);
  }

  final _newPasswordController = new BehaviorSubject<String>();
  Stream<String> get newPassword =>
      _newPasswordController.stream.transform(validatenewPassword);
  String get newPasswordValue => _newPasswordController.value;
  set setNewPassword(String event) => _newPasswordController.add(event);
  deletenewPassword() {
    _newPasswordController.add(null);
  }

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(email, password, (e, p) => true);
  bool validateNewPassword(n, p) {
    if (n == p) {
      return true;
    }
    print('no son iguales');
  }

  Stream<bool> get newPasswordValidStream => Observable.combineLatest2(
      newPassword, password, (n, p) => validateNewPassword(n, p));

  Stream<bool> get form2ValidStream => Observable.combineLatest3(
      name, check, formValidStream, (n, c, f) => true);
  final _nameController = new BehaviorSubject<String>();
  Stream<String> get name => _nameController.stream.transform(validateName);
  String get nameValue => _nameController.value;
  set setName(String event) => _nameController.add(event);
  deleteName() {
    _nameController.add(null);
  }

  final _checkController = new BehaviorSubject<bool>();
  Stream<bool> get check => _checkController.stream.transform(validateCheck);
  bool get checkValue => _checkController.value;
  set setCheck(bool event) => _checkController.add(event);
  deleteChek() {
    _checkController.add(null);
  }

  final _routeController = new BehaviorSubject<String>();
  Stream<String> get route => _routeController.stream;
  String get routeValue => _routeController.value;
  set setRoute(String event) => _routeController.add(event);
  deleteRoute() {
    _routeController.add(null);
  }

  deleteAll() {
    deleteEmail();
    deleteName();
    deletePassword();
    deleteChek();
  }
}
