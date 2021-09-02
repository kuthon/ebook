import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
