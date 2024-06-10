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

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
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

  /// `Confirm Password`
  String get HintConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'HintConfirmPassword',
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

  /// `Please enter a valid email with the domain @unmsm.edu.pe`
  String get ForgotPasswordSnackBar {
    return Intl.message(
      'Please enter a valid email with the domain @unmsm.edu.pe',
      name: 'ForgotPasswordSnackBar',
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

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get RegisterName {
    return Intl.message(
      'Name',
      name: 'RegisterName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get RegisterLastName {
    return Intl.message(
      'Last Name',
      name: 'RegisterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Student Code`
  String get RegisterStudentCode {
    return Intl.message(
      'Student Code',
      name: 'RegisterStudentCode',
      desc: '',
      args: [],
    );
  }

  /// `Institutional Email`
  String get RegisterInstitutionalEmail {
    return Intl.message(
      'Institutional Email',
      name: 'RegisterInstitutionalEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get RegisterPhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'RegisterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email and Phone`
  String get RegisterEmailAndPhoneTitle {
    return Intl.message(
      'Email and Phone',
      name: 'RegisterEmailAndPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `It must have at least 8 characters, a capital letter, a number and a special character.`
  String get RegisterPasswordRequired {
    return Intl.message(
      'It must have at least 8 characters, a capital letter, a number and a special character.',
      name: 'RegisterPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Accept the terms and conditions.`
  String get AcceptTerms {
    return Intl.message(
      'Accept the terms and conditions.',
      name: 'AcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid student code`
  String get RegisterInvalidCodeSnackBar {
    return Intl.message(
      'Please enter a valid student code',
      name: 'RegisterInvalidCodeSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `The email is already registered`
  String get RegisterUserExistsSnackBar {
    return Intl.message(
      'The email is already registered',
      name: 'RegisterUserExistsSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email with the domain @unmsm.edu.pe`
  String get RegisterInvalidEmailSnackBar {
    return Intl.message(
      'Please enter a valid email with the domain @unmsm.edu.pe',
      name: 'RegisterInvalidEmailSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `The email is not registered in the university`
  String get RegisterEmailNotFoundSnackBar {
    return Intl.message(
      'The email is not registered in the university',
      name: 'RegisterEmailNotFoundSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get RegisterInvalidPhoneSnackBar {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'RegisterInvalidPhoneSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions`
  String get RegisterTermsSnackBar {
    return Intl.message(
      'You must accept the terms and conditions',
      name: 'RegisterTermsSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get RegisterButton {
    return Intl.message(
      'Continue',
      name: 'RegisterButton',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get RegisterBack {
    return Intl.message(
      'Back',
      name: 'RegisterBack',
      desc: '',
      args: [],
    );
  }

  /// `Check your institutional email`
  String get EmailVerificationTitle {
    return Intl.message(
      'Check your institutional email',
      name: 'EmailVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action requires email verification, you will be asked to fill out the code. A verification email has been sent to:`
  String get EmailVerificationDescription {
    return Intl.message(
      'This action requires email verification, you will be asked to fill out the code. A verification email has been sent to:',
      name: 'EmailVerificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get ResendCode {
    return Intl.message(
      'Resend code',
      name: 'ResendCode',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get NavBarBottomTransaction {
    return Intl.message(
      'History',
      name: 'NavBarBottomTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get NavBarBottomHome {
    return Intl.message(
      'Home',
      name: 'NavBarBottomHome',
      desc: '',
      args: [],
    );
  }

  /// `Gift Shop`
  String get NavBarBottomGiftShop {
    return Intl.message(
      'Gift Shop',
      name: 'NavBarBottomGiftShop',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get NavBarBottomMessage {
    return Intl.message(
      'Messages',
      name: 'NavBarBottomMessage',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get NavBarBottomProfile {
    return Intl.message(
      'Profile',
      name: 'NavBarBottomProfile',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get ResponseCashback {
    return Intl.message(
      'Accept',
      name: 'ResponseCashback',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get SignOut {
    return Intl.message(
      'Sign Out',
      name: 'SignOut',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again later`
  String get DefaultErrorStatusCode {
    return Intl.message(
      'An error occurred, please try again later',
      name: 'DefaultErrorStatusCode',
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
