import 'package:ebook/components/custom_button.dart';
import 'package:ebook/components/pin_code_keyboard/pin_code_keyboard.dart';
import 'package:ebook/components/pin_code_keyboard/pin_code_progress_indicator.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetPinCodePage extends StatefulWidget {
  static const String routeName = '/set_pin_code';

  @override
  _SetPinCodePageState createState() => _SetPinCodePageState();
}

class _SetPinCodePageState extends State<SetPinCodePage> {
  late AppProvider _appProvider;

  final PinCodeKeyboard _keyboard = PinCodeKeyboard();

  String pinCode = '';

  _SetPinCodePageState() {
    _keyboard.textController.stream.listen((event) async {
      pinCode = event.toString();
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _appProvider = Provider.of<AppProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _keyboard.killStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 120,
            ),
            Text(
              '${S.of(context).set_pin_code}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(
              flex: 30,
            ),
            PinCodeProgressIndicator(
              progress: pinCode.length,
            ),
            Spacer(
              flex: 30,
            ),
            _keyboard,
            Spacer(
              flex: 120,
            ),
            CustomButton(
                onTap: pinCode.length == 4
                    ? () {
                        _appProvider.changePinCode(pinCode);
                        Navigator.pop(context);
                      }
                    : null,
                text: '${S.of(context).save_your_passcode}'),
            Spacer(
              flex: 15,
            ),
          ],
        ),
      ),
    );
  }
}
