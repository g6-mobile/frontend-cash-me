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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get LoginGoogle {
    return Intl.message(
      'Login with Google',
      name: 'LoginGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with your email`
  String get LoginEmail {
    return Intl.message(
      'Or sign in with your email',
      name: 'LoginEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get HintEmail {
    return Intl.message(
      'Email',
      name: 'HintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get HintPassword {
    return Intl.message(
      'Password',
      name: 'HintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot my password`
  String get ForgotPassword {
    return Intl.message(
      'Forgot my password',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get LoginButton {
    return Intl.message(
      'Continue',
      name: 'LoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get QuestionSignUp {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'QuestionSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get ForgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'ForgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `We will send an OTP code to your email to verify your identity`
  String get ForgotPasswordDescription {
    return Intl.message(
      'We will send an OTP code to your email to verify your identity',
      name: 'ForgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get EmailAddress {
    return Intl.message(
      'Email Address',
      name: 'EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get SendButton {
    return Intl.message(
      'Send',
      name: 'SendButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
