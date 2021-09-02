import 'package:ebook/generated/l10n.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).accentColor,
        ),
        Spacer(),
        Text(
          "${S.of(context).loading}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Spacer(),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
