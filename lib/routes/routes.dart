import 'package:flutter/material.dart';
import 'package:boat_monitor/pages/privacyPolicy_page.dart';
import 'package:boat_monitor/pages/resetPassword_page.dart';
import 'package:boat_monitor/pages/changePassword_page.dart';
import 'package:boat_monitor/pages/signUp_page.dart';

import '../pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'loadingPage': (BuildContext context) => LoginPage(),
    'signUpPage': (BuildContext context) => SignUpPage(),
    'resetPasswordPage': (BuildContext context) => ResetPasswordPage(),
    'changePasswordPage': (BuildContext context) => ChangePasswordPage(),
    'privacyPage': (BuildContext context) => PrivacyPage(),
  };
}
