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

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(email, password, (e, p) => true);
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

  deleteAll() {
    deleteEmail();
    deleteName();
    deletePassword();
    deleteChek();
  }
}
