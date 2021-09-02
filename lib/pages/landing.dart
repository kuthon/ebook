import 'package:ebook/pages/enter_pin_code.dart';
import 'package:ebook/pages/home.dart';
import 'package:ebook/pages/welcome.dart';
import 'package:ebook/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = '/landing';

  late AppProvider _appProvider;

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context);
    if (_appProvider.isFirstLaunch) return WelcomePage();

    if (_appProvider.pinCodeEntered) return HomePage();
    return EnterPinCodePage();
  }
}
