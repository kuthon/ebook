import 'package:ebook/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingsBloc extends StatelessWidget {
  const SettingsBloc({Key? key, required this.children, this.isFirst = false}) : super(key: key);

  final List<Widget> children;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          left: Constants.paddingXXL,
          right: Constants.paddingXL,
          top: Constants.paddingXXXL,
          bottom: Constants.paddingXL),
      decoration: BoxDecoration(
          borderRadius: isFirst ? BorderRadius.vertical(top: Radius.circular(Constants.borderRadiusL)) : null,
          color: Theme.of(context).primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
