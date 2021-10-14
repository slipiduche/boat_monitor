// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(boatName, userName) => "Are you sure you want to change ${boatName} responsible to ${userName}?";

  static m1(name) => "Welcome ${name}";

  static m2(firstName, lastName) => "My name is ${lastName}, ${firstName} ${lastName}";

  static m3(howMany) => "${Intl.plural(howMany, one: 'You have 1 notification', other: 'You have ${howMany} notifications')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "acceptConfirmation" : MessageLookupByLibrary.simpleMessage("Accept Confirmation"),
    "acept" : MessageLookupByLibrary.simpleMessage("Acept"),
    "aceptUsers" : MessageLookupByLibrary.simpleMessage("Are you sure you want to acept this users?"),
    "activeBoats" : MessageLookupByLibrary.simpleMessage("Active boats"),
    "alerts" : MessageLookupByLibrary.simpleMessage("Alerts"),
    "all" : MessageLookupByLibrary.simpleMessage("all"),
    "approval" : MessageLookupByLibrary.simpleMessage("Approval"),
    "aprove" : MessageLookupByLibrary.simpleMessage("Aprove"),
    "arrival" : MessageLookupByLibrary.simpleMessage("Arrival"),
    "arrivalConfirmation" : MessageLookupByLibrary.simpleMessage("Arrival Confirmation"),
    "arrived" : MessageLookupByLibrary.simpleMessage("Arrived"),
    "at" : MessageLookupByLibrary.simpleMessage("at"),
    "available" : MessageLookupByLibrary.simpleMessage("Available"),
    "averageTemperature" : MessageLookupByLibrary.simpleMessage("Last temperature"),
    "boat" : MessageLookupByLibrary.simpleMessage("Boat"),
    "camera" : MessageLookupByLibrary.simpleMessage("Camera"),
    "change" : MessageLookupByLibrary.simpleMessage("Change"),
    "changeBoatNameMessage" : MessageLookupByLibrary.simpleMessage("Are you sure you want to change boat name?"),
    "changeConfirmation" : MessageLookupByLibrary.simpleMessage("Change Confirmation"),
    "changePassword" : MessageLookupByLibrary.simpleMessage("Change password"),
    "changeResponsibleMessage" : m0,
    "changeTemperatureConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure you want to mark temperature?"),
    "changeTimeoutConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure you want to mark timeout?"),
    "changeWeightConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure you want to mark weight?"),
    "clicHere" : MessageLookupByLibrary.simpleMessage("Click here"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmation" : MessageLookupByLibrary.simpleMessage("Confirmation"),
    "currentStatus" : MessageLookupByLibrary.simpleMessage("Current status"),
    "currentWeight" : MessageLookupByLibrary.simpleMessage("Current weight"),
    "date" : MessageLookupByLibrary.simpleMessage("Date"),
    "dateCreated" : MessageLookupByLibrary.simpleMessage("Date created"),
    "decline" : MessageLookupByLibrary.simpleMessage("Decline"),
    "declineConfirmation" : MessageLookupByLibrary.simpleMessage("Decline Confirmation"),
    "declineUsers" : MessageLookupByLibrary.simpleMessage("Are you sure you want to decline this users?"),
    "defaultt" : MessageLookupByLibrary.simpleMessage("Default"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteConfirmation" : MessageLookupByLibrary.simpleMessage("Delete Confirmation"),
    "deleteFromSsd" : MessageLookupByLibrary.simpleMessage("Delete from SSD"),
    "deleteStorageConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this Journey data?"),
    "deleting" : MessageLookupByLibrary.simpleMessage("deleting"),
    "departure" : MessageLookupByLibrary.simpleMessage("Departure"),
    "departureConfirmation" : MessageLookupByLibrary.simpleMessage("Departure Confirmation"),
    "departureMessageConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure you want to mark this boat At"),
    "desiredTemperature" : MessageLookupByLibrary.simpleMessage("Desired temperature"),
    "diskSpace" : MessageLookupByLibrary.simpleMessage("Disk space: "),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "dontHaveAccount" : MessageLookupByLibrary.simpleMessage("Don’t have an account?"),
    "downloading" : MessageLookupByLibrary.simpleMessage("Downloading"),
    "duration" : MessageLookupByLibrary.simpleMessage("duration"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "finalDate" : MessageLookupByLibrary.simpleMessage("Final date"),
    "finalWeight" : MessageLookupByLibrary.simpleMessage("Final weight"),
    "forgot" : MessageLookupByLibrary.simpleMessage("Forgot your password ?"),
    "history" : MessageLookupByLibrary.simpleMessage("Historics"),
    "historyHintText" : MessageLookupByLibrary.simpleMessage("Type any boat name, travel id, supervisor"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "hours" : MessageLookupByLibrary.simpleMessage("Hours"),
    "iRead" : MessageLookupByLibrary.simpleMessage("I’ve read and accept all the"),
    "iceWeight" : MessageLookupByLibrary.simpleMessage("Ice weight"),
    "inBoat" : MessageLookupByLibrary.simpleMessage("in boat"),
    "inJourney" : MessageLookupByLibrary.simpleMessage("in journey"),
    "inactiveBoats" : MessageLookupByLibrary.simpleMessage("Inactive boats"),
    "initialDate" : MessageLookupByLibrary.simpleMessage("Initial date"),
    "isNotEmail" : MessageLookupByLibrary.simpleMessage("Invalid Email"),
    "location" : MessageLookupByLibrary.simpleMessage("Location"),
    "loginButtonText" : MessageLookupByLibrary.simpleMessage("Login"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmation" : MessageLookupByLibrary.simpleMessage("Are you sure to log out?"),
    "manageBoat" : MessageLookupByLibrary.simpleMessage("Manage boat"),
    "manager" : MessageLookupByLibrary.simpleMessage("Manager"),
    "mustBeEqual" : MessageLookupByLibrary.simpleMessage("Passwords must be equal"),
    "mustHave" : MessageLookupByLibrary.simpleMessage("Passwords must be at least 6 characters long"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("New Password"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noData" : MessageLookupByLibrary.simpleMessage("No data"),
    "ok" : MessageLookupByLibrary.simpleMessage("Ok"),
    "parameter" : MessageLookupByLibrary.simpleMessage("Parameter"),
    "parameters" : MessageLookupByLibrary.simpleMessage("Parameters"),
    "passWord" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRecovery" : MessageLookupByLibrary.simpleMessage("Password Recovery"),
    "pictures" : MessageLookupByLibrary.simpleMessage("Pictures"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacyPolicyText" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
    "recoveryText" : MessageLookupByLibrary.simpleMessage("Please introduce your email and check your inbox."),
    "resetPasswordButtonText" : MessageLookupByLibrary.simpleMessage("Accept"),
    "restore" : MessageLookupByLibrary.simpleMessage("Restore"),
    "restoring" : MessageLookupByLibrary.simpleMessage("Restoring"),
    "sail" : MessageLookupByLibrary.simpleMessage("Sail"),
    "sailing" : MessageLookupByLibrary.simpleMessage("Sailing"),
    "sailingDays" : MessageLookupByLibrary.simpleMessage("Sailing days"),
    "sailingTime" : MessageLookupByLibrary.simpleMessage("Sailing time"),
    "selectUserResponsible" : MessageLookupByLibrary.simpleMessage("Select user responsible"),
    "selected" : MessageLookupByLibrary.simpleMessage("Selected"),
    "setPointConfirmation" : MessageLookupByLibrary.simpleMessage("Setpoint Confirmation"),
    "signUp" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpMessage" : MessageLookupByLibrary.simpleMessage("Sign up and start working with us"),
    "signupHere" : MessageLookupByLibrary.simpleMessage("Sign up here"),
    "simpleText" : MessageLookupByLibrary.simpleMessage("Hello world"),
    "status" : MessageLookupByLibrary.simpleMessage("Status"),
    "storage" : MessageLookupByLibrary.simpleMessage("Storage"),
    "supervisor" : MessageLookupByLibrary.simpleMessage("Supervisor"),
    "suspiciousAlert" : MessageLookupByLibrary.simpleMessage("Suspicious activity detected"),
    "tempAlert" : MessageLookupByLibrary.simpleMessage("Temperature Alert detected"),
    "temperature" : MessageLookupByLibrary.simpleMessage("Temperature"),
    "textWithPlaceholder" : m1,
    "textWithPlaceholders" : m2,
    "textWithPlural" : m3,
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "timeout" : MessageLookupByLibrary.simpleMessage("Timeout"),
    "travel" : MessageLookupByLibrary.simpleMessage("Travel"),
    "typeAnyBoatName" : MessageLookupByLibrary.simpleMessage("Type any boat name"),
    "typeAnyTravel" : MessageLookupByLibrary.simpleMessage("Type any travel"),
    "typeBoatName" : MessageLookupByLibrary.simpleMessage("Type boat name"),
    "typeNumber" : MessageLookupByLibrary.simpleMessage("Type number"),
    "unavailable" : MessageLookupByLibrary.simpleMessage("Unavailable"),
    "unreachableAlert" : MessageLookupByLibrary.simpleMessage("Docked Boat out of reach"),
    "updating" : MessageLookupByLibrary.simpleMessage("Updating"),
    "user" : MessageLookupByLibrary.simpleMessage("User"),
    "value" : MessageLookupByLibrary.simpleMessage("Value"),
    "waiting" : MessageLookupByLibrary.simpleMessage("Waiting for approval"),
    "weight" : MessageLookupByLibrary.simpleMessage("Weight"),
    "weigthAlert" : MessageLookupByLibrary.simpleMessage("Weight Alert detected"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
