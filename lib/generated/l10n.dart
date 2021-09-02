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

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Further`
  String get further {
    return Intl.message(
      'Further',
      name: 'further',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Hello, thank you for downloading our app, here you can read books and add them to your favorites and also protect your preferences`
  String get hello_thanks_for_downloading {
    return Intl.message(
      'Hello, thank you for downloading our app, here you can read books and add them to your favorites and also protect your preferences',
      name: 'hello_thanks_for_downloading',
      desc: '',
      args: [],
    );
  }

  /// `All Books`
  String get all_books {
    return Intl.message(
      'All Books',
      name: 'all_books',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get my_account {
    return Intl.message(
      'My Account',
      name: 'my_account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Security Settings`
  String get security_settings {
    return Intl.message(
      'Security Settings',
      name: 'security_settings',
      desc: '',
      args: [],
    );
  }

  /// `Blocking the reader`
  String get blocking_the_reader {
    return Intl.message(
      'Blocking the reader',
      name: 'blocking_the_reader',
      desc: '',
      args: [],
    );
  }

  /// `Reader Protection`
  String get reader_protection {
    return Intl.message(
      'Reader Protection',
      name: 'reader_protection',
      desc: '',
      args: [],
    );
  }

  /// `Not installed`
  String get not_installed {
    return Intl.message(
      'Not installed',
      name: 'not_installed',
      desc: '',
      args: [],
    );
  }

  /// `Installed`
  String get installed {
    return Intl.message(
      'Installed',
      name: 'installed',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Send notifications`
  String get send_notifications {
    return Intl.message(
      'Send notifications',
      name: 'send_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Sending time`
  String get sending_time {
    return Intl.message(
      'Sending time',
      name: 'sending_time',
      desc: '',
      args: [],
    );
  }

  /// `Set a PIN Code`
  String get set_pin_code {
    return Intl.message(
      'Set a PIN Code',
      name: 'set_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter a PIN Code`
  String get enter_pin_code {
    return Intl.message(
      'Enter a PIN Code',
      name: 'enter_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Save Your passcode`
  String get save_your_passcode {
    return Intl.message(
      'Save Your passcode',
      name: 'save_your_passcode',
      desc: '',
      args: [],
    );
  }

  /// `Choose a reader theme`
  String get choose_theme {
    return Intl.message(
      'Choose a reader theme',
      name: 'choose_theme',
      desc: '',
      args: [],
    );
  }

  /// `Apply Theme`
  String get apply_theme {
    return Intl.message(
      'Apply Theme',
      name: 'apply_theme',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Current theme`
  String get current_theme {
    return Intl.message(
      'Current theme',
      name: 'current_theme',
      desc: '',
      args: [],
    );
  }

  /// `PIN Code`
  String get pin_code {
    return Intl.message(
      'PIN Code',
      name: 'pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Add book`
  String get add_book {
    return Intl.message(
      'Add book',
      name: 'add_book',
      desc: '',
      args: [],
    );
  }

  /// `Search for books`
  String get search_for_books {
    return Intl.message(
      'Search for books',
      name: 'search_for_books',
      desc: '',
      args: [],
    );
  }

  /// `Book name`
  String get book_name {
    return Intl.message(
      'Book name',
      name: 'book_name',
      desc: '',
      args: [],
    );
  }

  /// `Books not found`
  String get books_not_found {
    return Intl.message(
      'Books not found',
      name: 'books_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get reading {
    return Intl.message(
      'Reading',
      name: 'reading',
      desc: '',
      args: [],
    );
  }

  /// `Reverse reading`
  String get reverse_reading {
    return Intl.message(
      'Reverse reading',
      name: 'reverse_reading',
      desc: '',
      args: [],
    );
  }

  /// `No books yet`
  String get no_books_yet {
    return Intl.message(
      'No books yet',
      name: 'no_books_yet',
      desc: '',
      args: [],
    );
  }

  /// `Supported formats: epub, fb2, txt`
  String get supported_formats {
    return Intl.message(
      'Supported formats: epub, fb2, txt',
      name: 'supported_formats',
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
      Locale.fromSubtags(languageCode: 'ru'),
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
