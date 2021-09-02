import 'package:ebook/components/pin_code_keyboard/pin_code_keyboard.dart';
import 'package:ebook/components/pin_code_keyboard/pin_code_progress_indicator.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnterPinCodePage extends StatefulWidget {
  static const String routeName = '/enter_pin_code';

  @override
  _EnterPinCodePageState createState() => _EnterPinCodePageState();
}

class _EnterPinCodePageState extends State<EnterPinCodePage> {
  late AppProvider _appProvider;

  final PinCodeKeyboard _keyboard = PinCodeKeyboard();

  String pinCode = '';

  _EnterPinCodePageState() {
    _keyboard.textController.stream.listen((event) async {
      pinCode = event.toString();
      setState(() {});
      if (pinCode.length == 4) {
        if (pinCode != _appProvider.pinCode) {
          await Future.delayed(Duration(milliseconds: 200), () {
            HapticFeedback.vibrate();
            _keyboard.updatePinCode('');
          });
        } else {
          _appProvider.pinCodeEntered = true;
        }
      }
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
              '${S.of(context).enter_pin_code}',
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
              flex: 150,
            ),
          ],
        ),
      ),
    );
  }
}
