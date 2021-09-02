import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Image.asset(
      ('assets/images/splash_background.png'),
      fit: BoxFit.fill,
    ));
  }
}
