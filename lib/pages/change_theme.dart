import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ebook/components/custom_button.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeThemePage extends StatefulWidget {
  static const String routeName = '/change_theme';

  const ChangeThemePage({Key? key}) : super(key: key);

  @override
  _ChangeThemePageState createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  late bool _isDarkTheme;

  @override
  void didChangeDependencies() {
    _isDarkTheme = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 50,
            ),
            Text(
              '${S.of(context).choose_theme}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(
              flex: 20,
            ),
            Expanded(
              flex: 160,
              child: Image.asset('assets/images/phone.png'),
            ),
            Spacer(
              flex: 24,
            ),
            Row(
              children: [
                SizedBox(
                  width: 24,
                ),
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: _isDarkTheme ? Theme.of(context).primaryColor : Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        setState(() {
                          _isDarkTheme = false;
                        });
                      },
                      child: Icon(
                        _isDarkTheme ? CupertinoIcons.sun_min : Icons.check,
                        color: _isDarkTheme ? Theme.of(context).buttonColor : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: _isDarkTheme ? Theme.of(context).buttonColor : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        setState(() {
                          _isDarkTheme = true;
                        });
                      },
                      child: Icon(
                        _isDarkTheme ? Icons.check : CupertinoIcons.moon,
                        color: _isDarkTheme ? Theme.of(context).primaryColor : Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 20,
            ),
            CustomButton(
                onTap: () {
                  _isDarkTheme ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
                },
                text: '${S.of(context).apply_theme}'),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}
