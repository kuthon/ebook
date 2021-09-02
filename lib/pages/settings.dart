import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ebook/components/custom_divider.dart';
import 'package:ebook/components/custom_drop_down.dart';
import 'package:ebook/components/settings_bloc.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/pages/change_theme.dart';
import 'package:ebook/pages/set_pin_code.dart';
import 'package:ebook/providers/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AppProvider _appProvider;

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${S.of(context).settings}'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SettingsBloc(isFirst: true, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).language}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                CustomDropDown(
                    values: [..._appProvider.languages, '${S.of(context).system}'],
                    selectedValue: _appProvider.language ?? '${S.of(context).system}',
                    onChange: (newValue) => _appProvider.changeLanguage(newValue))
              ],
            )
          ]),
          CustomDivider(),
          SettingsBloc(children: [
            Text(
              '${S.of(context).security_settings}',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).blocking_the_reader}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Switch(
                    value: _appProvider.isPinCode,
                    onChanged: (_) {
                      _appProvider.changePinCodeProtection();
                      setState(() {});
                    }),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).pin_code}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SetPinCodePage.routeName);
                    },
                    child: Text(
                      '${S.of(context).change}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ))
              ],
            ),
          ]),
          CustomDivider(),
          SettingsBloc(children: [
            Text(
              '${S.of(context).notifications}',
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).send_notifications}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Switch(
                    value: _appProvider.isNotifications,
                    onChanged: (_) {
                      _appProvider.changeNotificationsStatus();
                      setState(() {});
                    }),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).sending_time}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextButton(
                    child: Text(
                      '${_appProvider.notificationsTime.format(context)}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    onPressed: () async {
                      TimeOfDay? _time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (_time == null) return;
                      _appProvider.changeNotificationsTime(_time);
                    })
              ],
            ),
          ]),
          CustomDivider(),
          SettingsBloc(
            children: [
              Text(
                '${S.of(context).theme}',
                style: Theme.of(context).textTheme.caption,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).current_theme}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChangeThemePage.routeName);
                      },
                      child: Text(
                        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                            ? S.of(context).dark
                            : S.of(context).light,
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                ],
              ),
            ],
          ),
          CustomDivider(),
          Expanded(
              child: SettingsBloc(
            children: [
              Text(
                '${S.of(context).reading}',
                style: Theme.of(context).textTheme.caption,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).reverse_reading}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Switch(
                      value: _appProvider.reverse,
                      onChanged: (_) {
                        _appProvider.changeReadingMode();
                        setState(() {});
                      }),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
