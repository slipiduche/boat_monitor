import 'package:flutter/material.dart';

import '../pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'loadingPage': (BuildContext context) => LoginPage(),
  };
}
