class Parameters {
  //final domain = 'https://www.orbittas.com/'; //server domain
  final domain = 'https://192.168.0.103:9443/'; //server domain
  final login = 'login'; //endpoints
  final recovery = 'recovery';
  final historics = 'historics';
  final users = 'users';
  final boats = 'boats';
  final journeys = 'journeys';
  final files = 'files';
  final create = 'create';
  final modify = 'modify';
  final status = 'status';

  Parameters();
  String get loginUrl {
    return domain + login;
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

  String get createUrl {
    return domain + create;
  }

  String get modifyUrl {
    return domain + modify;
  }

  String get statusUrl {
    return domain + status;
  }
}
