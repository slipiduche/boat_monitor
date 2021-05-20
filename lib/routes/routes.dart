import 'package:boat_monitor/pages/alertsPage.dart';
import 'package:boat_monitor/pages/approvalPage.dart';
import 'package:boat_monitor/pages/currentBoat_page.dart';
import 'package:boat_monitor/pages/historyPage.dart';
import 'package:boat_monitor/pages/homePage.dart';
import 'package:boat_monitor/pages/journeyPage.dart';
import 'package:boat_monitor/pages/manageBoatPage.dart';
import 'package:boat_monitor/pages/managerPage.dart';
import 'package:boat_monitor/pages/parametersPage.dart';

import 'package:boat_monitor/pages/supervisorPage.dart';
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
    'managerPage': (BuildContext context) => ManagerPage(),
    'alertsPage': (BuildContext context) => AlertPage(),
    'approvalPage': (BuildContext context) => ApprovalPage(),
    'parametersPage': (BuildContext context) => ParametersPage(),
    'homePage': (BuildContext context) => HomePage(),
    'historyPage': (BuildContext context) => HistoryPage(),
    'journeyPage': (BuildContext context) => JourneyPage(),
    'manageBoatPage': (BuildContext context) => ManageBoatPage(),
    'supervisorPage': (BuildContext context) => SupervisorPage(),
    'currentBoatPage': (BuildContext context) => CurrentBoatPage(),
  };
}
