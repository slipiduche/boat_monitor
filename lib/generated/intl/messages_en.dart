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

  static m0(name) => "Welcome ${name}";

  static m1(firstName, lastName) => "My name is ${lastName}, ${firstName} ${lastName}";

  static m2(howMany) => "${Intl.plural(howMany, one: 'You have 1 notification', other: 'You have ${howMany} notifications')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "clicHere" : MessageLookupByLibrary.simpleMessage("Clic here"),
    "dontHaveAccount" : MessageLookupByLibrary.simpleMessage("Don’t have an account?"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "forgot" : MessageLookupByLibrary.simpleMessage("Forgot your password ?"),
    "iRead" : MessageLookupByLibrary.simpleMessage("I’ve read and accept all the"),
    "loginButtonText" : MessageLookupByLibrary.simpleMessage("Login"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "passWord" : MessageLookupByLibrary.simpleMessage("Password"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "signUp" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpMessage" : MessageLookupByLibrary.simpleMessage("Sign up and start working with us"),
    "signupHere" : MessageLookupByLibrary.simpleMessage("Sign up here"),
    "simpleText" : MessageLookupByLibrary.simpleMessage("Hello world"),
    "textWithPlaceholder" : m0,
    "textWithPlaceholders" : m1,
    "textWithPlural" : m2
  };
}
