import 'package:ebook/components/custom_button.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/pages/set_pin_code.dart';
import 'package:ebook/providers/app.dart';
import 'package:ebook/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = '/welcome';

  late AppProvider _appProvider;

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Column(children: [
        Spacer(flex: 227),
        Text(
          '${S.of(context).welcome}',
          style: Theme.of(context).textTheme.headline5,
        ),
        Spacer(
          flex: 45,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.paddingXXXL),
          child: Text(
            '${S.of(context).hello_thanks_for_downloading}',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(
          flex: 185,
        ),
        CustomButton(
          onTap: () async {
            await Navigator.pushNamed(context, SetPinCodePage.routeName);
            _appProvider.firstLaunch();
          },
          text: '${S.of(context).further}',
        ),
        Spacer(
          flex: 30,
        )
      ]),
    );
  }
}
