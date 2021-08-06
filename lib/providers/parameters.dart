class Parameters {
  static final Parameters _singleton = new Parameters._internal();

  factory Parameters() {
    return _singleton;
  }

  Parameters._internal();

  String userName, mqttPassword;
  set user(_user) {
    userName = _user;
  }

  String get user {
    return userName;
  }

  set password(_user) {
    mqttPassword = _user;
  }

  String get password {
    return mqttPassword;
  }

  //final domain = 'https://www.orbittas.com/'; //server domain
  final domain = 'https://66.29.140.221:9443/'; //server domain
  final domainMqtt = '66.29.140.221';
  final portMqtt = 3000;
  final login = 'login'; //endpoints
  final recovery = 'recovery';
  final historics = 'historics';
  final users = 'users';
  final boats = 'boats';
  final journeys = 'journeys';
  final files = 'files';
  final filesZip = 'files/zip';
  final create = 'create';
  final signUp = 'signup';
  final modify = 'modify';
  final status = 'status';
  final alerts = 'alerts';
  final parameters = 'params';

  String get loginUrl {
    return domain + login;
  }

  String get parametersUrl {
    return domain + parameters;
  }

  String get alertsUrl {
    return domain + alerts;
  }

  String get recoveryUrl {
    return domain + recovery;
  }

  String get historicsUrl {
    return domain + historics;
  }

  String get usersUrl {
    return domain + users;
  }

  String get boatsUrl {
    return domain + boats;
  }

  String get journeysUrl {
    return domain + journeys;
  }

  String get filesUrl {
    return domain + files;
  }

  String get filesZipUrl {
    return domain + filesZip;
  }

  String get createUrl {
    return domain + create;
  }

  String get signUpUrl {
    return domain + signUp;
  }

  String get modifyUrl {
    return domain + modify;
  }

  String get statusUrl {
    return domain + status;
  }
}
/*
User: orbittas@orbittas.com
Password: #B04tTr4ck3r++
*/
