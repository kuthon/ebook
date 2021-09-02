import 'dart:async';

import 'package:ebook/components/pin_code_keyboard/pin_code_key.dart';
import 'package:ebook/presentation/my_icons.dart';
import 'package:flutter/material.dart';

class PinCodeKeyboard extends StatelessWidget {
  String _pinCode = '';

  String get pinCode => _pinCode;

  final StreamController<String> textController = StreamController<String>();

  void killStream() {
    textController.close();
  }

  void updatePinCode(String newPinCode) {
    if (newPinCode.length > 4) newPinCode = newPinCode.substring(0, 4);
    _pinCode = newPinCode;
    textController.add(_pinCode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Row(
              children: [
                for (int j = 0; j < 3; j++)
                  Expanded(
                      child: PinCodeKey(
                          onTap: () {
                            updatePinCode(_pinCode + '${i * 3 + j + 1}');
                          },
                          child: Text(
                            '${i * 3 + j + 1}',
                            style: Theme.of(context).textTheme.headline5,
                          )))
              ],
            ),
          Row(
            children: [
              Spacer(),
              Expanded(
                child: PinCodeKey(
                    onTap: () {
                      updatePinCode(_pinCode + '0');
                    },
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.headline5,
                    )),
              ),
              Expanded(
                child: PinCodeKey(
                    onTap: () {
                      if (_pinCode.length > 0) updatePinCode(_pinCode.substring(0, _pinCode.length - 1));
                    },
                    child: Icon(
                      MyIcons.backspace,
                      size: Theme.of(context).textTheme.headline5!.fontSize,
                      color: Theme.of(context).textTheme.headline5!.color,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
