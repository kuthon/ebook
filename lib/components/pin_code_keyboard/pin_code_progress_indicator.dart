import 'package:flutter/material.dart';

class PinCodeProgressIndicator extends StatelessWidget {
  final int progress;

  PinCodeProgressIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 12,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: progress > 0 ? Theme.of(context).accentColor : Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: progress > 1 ? Theme.of(context).accentColor : Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: progress > 2 ? Theme.of(context).accentColor : Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: progress > 3 ? Theme.of(context).accentColor : Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
