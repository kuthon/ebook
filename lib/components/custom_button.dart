import 'package:ebook/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  late final void Function()? onTap;
  late final String text;

  CustomButton({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Constants.paddingL),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.borderRadiusM), color: Theme.of(context).buttonColor),
        child: InkWell(
          borderRadius: BorderRadius.circular(Constants.borderRadiusM),
          onTap: onTap,
          splashColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Constants.paddingXL),
            child: Text(text, style: Theme.of(context).textTheme.button, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
