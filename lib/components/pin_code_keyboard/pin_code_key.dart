import 'package:flutter/material.dart';

class PinCodeKey extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;

  PinCodeKey({this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Center(child: child),
          height: 50,
        ),
      ),
    );
  }
}
