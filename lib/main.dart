import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ebook/pages/change_theme.dart';
import 'package:ebook/pages/enter_pin_code.dart';
import 'package:ebook/pages/favorites_books.dart';
import 'package:ebook/pages/home.dart';
import 'package:ebook/pages/landing.dart';
import 'package:ebook/pages/search.dart';
import 'package:ebook/pages/set_pin_code.dart';
import 'package:ebook/pages/settings.dart';
import 'package:ebook/pages/splash.dart';
import 'package:ebook/pages/welcome.dart';
import 'package:ebook/providers/app.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/themes/dark.dart';
import 'package:ebook/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppProvider _appProvider = AppProvider();

  final BooksProvider _booksProvider = BooksProvider();

  void _init() async {
    await _appProvider.init();
    await _booksProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future(() => _init()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashPage();
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<AppProvider>.value(value: _appProvider),
                ChangeNotifierProvider<BooksProvider>.value(value: _booksProvider),
              ],
              child: AdaptiveTheme(
                  light: kLightThemeData,
                  dark: kDarkThemeData,
                  initial: _appProvider.isDarkTheme ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
                  builder: (light, dark) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'E-book',
                        theme: light,
                        darkTheme: dark,
                        localizationsDelegates: [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        locale: _appProvider.locale.toString() != 'null' ? _appProvider.locale : null,
                        initialRoute: LandingPage.routeName,
                        routes: {
                          LandingPage.routeName: (_) => LandingPage(),
                          HomePage.routeName: (_) => HomePage(),
                          WelcomePage.routeName: (_) => WelcomePage(),
                          SettingsPage.routeName: (_) => SettingsPage(),
                          SplashPage.routeName: (_) => SplashPage(),
                          ChangeThemePage.routeName: (_) => ChangeThemePage(),
                          SetPinCodePage.routeName: (_) => SetPinCodePage(),
                          EnterPinCodePage.routeName: (_) => EnterPinCodePage(),
                          FavoritesBooksPage.routeName: (_) => FavoritesBooksPage(),
                          SearchPage.routeName: (_) => SearchPage(),
                          //ReadBook.routeName: (_) => ReadBook(),
                        },
                      )));
        });
  }
}
