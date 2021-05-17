// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class TextLanguage {
  TextLanguage();
  
  static TextLanguage current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<TextLanguage> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      TextLanguage.current = TextLanguage();
      
      return TextLanguage.current;
    });
  } 

  static TextLanguage of(BuildContext context) {
    return Localizations.of<TextLanguage>(context, TextLanguage);
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `Approval`
  String get approval {
    return Intl.message(
      'Approval',
      name: 'approval',
      desc: '',
      args: [],
    );
  }

  /// `Parameters`
  String get parameters {
    return Intl.message(
      'Parameters',
      name: 'parameters',
      desc: '',
      args: [],
    );
  }

  /// `Manage boat`
  String get manageBoat {
    return Intl.message(
      'Manage boat',
      name: 'manageBoat',
      desc: '',
      args: [],
    );
  }

  /// `Alerts`
  String get alerts {
    return Intl.message(
      'Alerts',
      name: 'alerts',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Supervisor`
  String get supervisor {
    return Intl.message(
      'Supervisor',
      name: 'supervisor',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for approval`
  String get waiting {
    return Intl.message(
      'Waiting for approval',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Password Recovery`
  String get passwordRecovery {
    return Intl.message(
      'Password Recovery',
      name: 'passwordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Please introduce your email and check your inbox.`
  String get recoveryText {
    return Intl.message(
      'Please introduce your email and check your inbox.',
      name: 'recoveryText',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Updating`
  String get updating {
    return Intl.message(
      'Updating',
      name: 'updating',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passWord {
    return Intl.message(
      'Password',
      name: 'passWord',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up here`
  String get signupHere {
    return Intl.message(
      'Sign up here',
      name: 'signupHere',
      desc: '',
      args: [],
    );
  }

  /// `Sign up and start working with us`
  String get signUpMessage {
    return Intl.message(
      'Sign up and start working with us',
      name: 'signUpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password ?`
  String get forgot {
    return Intl.message(
      'Forgot your password ?',
      name: 'forgot',
      desc: '',
      args: [],
    );
  }

  /// `Clic here`
  String get clicHere {
    return Intl.message(
      'Clic here',
      name: 'clicHere',
      desc: '',
      args: [],
    );
  }

  /// `I’ve read and accept all the`
  String get iRead {
    return Intl.message(
      'I’ve read and accept all the',
      name: 'iRead',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Acept`
  String get resetPasswordButtonText {
    return Intl.message(
      'Acept',
      name: 'resetPasswordButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Is not an email`
  String get isNotEmail {
    return Intl.message(
      'Is not an email',
      name: 'isNotEmail',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must be at least 6 characters long`
  String get mustHave {
    return Intl.message(
      'Passwords must be at least 6 characters long',
      name: 'mustHave',
      desc: '',
      args: [],
    );
  }

  /// `Hello world`
  String get simpleText {
    return Intl.message(
      'Hello world',
      name: 'simpleText',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}`
  String textWithPlaceholder(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'textWithPlaceholder',
      desc: '',
      args: [name],
    );
  }

  /// `My name is {lastName}, {firstName} {lastName}`
  String textWithPlaceholders(Object firstName, Object lastName) {
    return Intl.message(
      'My name is $lastName, $firstName $lastName',
      name: 'textWithPlaceholders',
      desc: '',
      args: [firstName, lastName],
    );
  }

  /// `{howMany, plural, one{You have 1 notification} other{You have {howMany} notifications}}`
  String textWithPlural(num howMany) {
    return Intl.plural(
      howMany,
      one: 'You have 1 notification',
      other: 'You have $howMany notifications',
      name: 'textWithPlural',
      desc: '',
      args: [howMany],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TextLanguage> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<TextLanguage> load(Locale locale) => TextLanguage.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}