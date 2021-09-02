import 'dart:convert';

import 'package:ebook/services/notifications.dart';
import 'package:ebook/services/preferences_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  /// key for [_localStorageService]
  static const String storageKey = 'app_storage_key';

  /// [_localStorageService] carries out work with Shared Preferences
  PreferencesStorageService _localStorageService = PreferencesStorageService();

  NotificationService _notificationService = NotificationService();

  /// [languages] - list of languages supported in the application
  final List<String> languages = ['English', 'Русский'];

  /// current language
  /// if the value is null, the system value is used
  String? _language;

  /// [_locale] - current Locale
  /// if the value is null, the system value is used
  Locale? _locale;

  /// [_pinCode] - current pin code
  String? _pinCode;

  /// [_isPinCode] - is pin code protection enabled
  bool? _isPinCode;

  /// if [_isFirstLaunch] != false - the application is installed for the first time
  /// It is needed to show the user the [WelcomePage]
  bool? _isFirstLaunch;

  /// [_notificationsTime] - daily notification time
  TimeOfDay? _notificationsTime;

  /// [_isNotifications] - is notifications enabled
  bool? _isNotifications;

  /// [_pinCodeEntered] - did the user enter a pin code
  bool _pinCodeEntered = false;

  /// [_reverse] - reverse reading mode
  bool? _reverse;

  /// current theme, used for initialization
  bool? _isDarkTheme;

  bool get pinCodeEntered => !isPinCode || _pinCodeEntered;

  set pinCodeEntered(bool value) {
    _pinCodeEntered = value;
    notifyListeners();
  }

  bool get isPinCode => _isPinCode ?? false;

  String? get pinCode => _pinCode;

  bool get isNotifications => _isNotifications ?? false;

  bool get isFirstLaunch => _isFirstLaunch ?? true;

  TimeOfDay get notificationsTime => _notificationsTime ?? TimeOfDay(hour: 10, minute: 0);

  Locale? get locale => _locale;

  String? get language => _language;

  bool get isDarkTheme => _isDarkTheme ?? true;

  bool get reverse => _reverse ?? false;

  /// the method must be called once at a time
  /// after familiarizing the user with the application
  void firstLaunch() {
    _isFirstLaunch = false;
    pinCodeEntered = true;
    notifyListeners();
    _saveData();
  }

  void changePinCodeProtection() {
    _pinCodeEntered = true;
    _isPinCode = !isPinCode;
    notifyListeners();
    _saveData();
  }

  void changePinCode(String newPinCode) {
    _pinCode = newPinCode;
    notifyListeners();
    _saveData();
  }

  void changeNotificationsStatus() {
    _isNotifications = !isNotifications;

    if (isNotifications == false)
      _notificationService.deleteDailyNotifications();
    else {
      DateTime now = DateTime.now();

      _notificationService.scheduleDailyTenAMNotification(
          title: 'Hello!',
          body: "It's time to read",
          time: DateTime(now.year, now.month, now.day, notificationsTime.hour, notificationsTime.minute));
    }

    notifyListeners();
    _saveData();
  }

  void changeNotificationsTime(TimeOfDay? newTime) {
    _notificationsTime = newTime;

    if (isNotifications) {
      DateTime now = DateTime.now();

      _notificationService.scheduleDailyTenAMNotification(
          title: 'Hello!',
          body: "It's time to read",
          time: DateTime(now.year, now.month, now.day, notificationsTime.hour, notificationsTime.minute));
    }
    notifyListeners();
    _saveData();
  }

  void changeLanguage(String newLanguage) {
    if (newLanguage == 'English') {
      _locale = Locale.fromSubtags(languageCode: 'en');
      _language = newLanguage;
    } else if (newLanguage == 'Русский') {
      _locale = Locale.fromSubtags(languageCode: 'ru');
      _language = newLanguage;
    } else {
      _locale = null;
      _language = null;
    }
    notifyListeners();
    _saveData();
  }

  void changeReadingMode() {
    _reverse = !reverse;
    notifyListeners();
    _saveData();
  }

  /// updates data in Local Storage
  void _saveData() async {
    String res = this.toJSON();

    await _localStorageService.set(storageKey, res);
  }

  /// You must call this method before starting the application
  Future<void> init() async {
    /// get values from local storage
    var response = await _localStorageService.get(storageKey);
    _isFirstLaunch = true;
    if (response == null) return;
    _isFirstLaunch = false;
    var jsonRes = await jsonDecode(response.toString());

    if (jsonRes['response']['items'][0]['language']['language_code'] != null &&
        jsonRes['response']['items'][0]['language']['language_code'] != 'null') {
      _locale = Locale.fromSubtags(languageCode: jsonRes['response']['items'][0]['language']['language_code']);
      _language = jsonRes['response']['items'][0]['language']['language_name'];
    }

    if (jsonRes['response']['items'][1]['notifications_time']['hour'] != 'null' &&
        jsonRes['response']['items'][1]['notifications_time']['hour'] != null) {
      _notificationsTime = TimeOfDay(
          hour: jsonRes['response']['items'][1]['notifications_time']['hour'] as int,
          minute: jsonRes['response']['items'][1]['notifications_time']['minute'] as int);
      _isNotifications = jsonRes['response']['items'][1]['is_notifications'];
    }
    if (jsonRes['response']['items'][2]['protection']['pin_code'] != 'null' &&
        jsonRes['response']['items'][2]['protection']['pin_code'] != null) {
      _pinCode = jsonRes['response']['items'][2]['protection']['pin_code'];
      _isPinCode = jsonRes['response']['items'][2]['protection']['is_pin_code'] as bool;
    }
    if (jsonRes['response']['items'][3]['is_dark_theme'] != null &&
        jsonRes['response']['items'][3]['is_dark_theme'] != 'null') {
      _isDarkTheme = jsonRes['response']['items'][3]['is_dark_theme'] as bool;
    }
    if (jsonRes['response']['items'][4]['reverse'] != null && jsonRes['response']['items'][4]['reverse'] != 'null') {
      _reverse = jsonRes['response']['items'][4]['reverse'] as bool;
    }

    await _notificationService.initNotifications();
    if (isNotifications) {
      DateTime now = DateTime.now();

      await _notificationService.scheduleDailyTenAMNotification(
          title: 'Hello!',
          body: "It's time to read",
          time: DateTime(now.year, now.month, now.day, notificationsTime.hour, notificationsTime.minute));
    }
  }

  /// returns a json string to save data with [_localStorageService]
  String toJSON() {
    return '''
    {
      "response": {
        "items": [
          {
            "language": {
              "language_code": "${locale?.languageCode}",
              "language_name": "$language"
            }
          },
          {
            "notifications_time": {
              "hour": ${notificationsTime.hour},
              "minute": ${notificationsTime.minute}
            },
            "is_notifications": $isNotifications
          },
          {
            "protection": {
              "pin_code": "$pinCode",
              "is_pin_code": $isPinCode
            }
          },
          {
            "is_dark_theme": $isDarkTheme
          },
          {
            "reverse": $reverse
          }
        ]
       }
    }
    ''';
  }
}
