import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  // GET y SET del token
  //
  //
  get token {
    return _prefs.getString('token') ?? '';
  }

  get token1 {
    return _prefs.getString('token1') ?? '';
  }

  get token2 {
    return _prefs.getString('token2') ?? '';
  }

  get token3 {
    return _prefs.getString('token3') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del nombre
  get name {
    return _prefs.getString('nombre') ?? '';
  }

  set name(String value) {
    _prefs.setString('nombre', value);
  }

  // GET y SET del email
  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  // GET y SET del userId
  get userId {
    return _prefs.getInt('userId') ?? '';
  }

  set userId(int value) {
    _prefs.setInt('userId', value);
  }
}
