import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  LoadingDialog({
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 14),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            message.toString() + ", Please Wait...",
          ),
        ],
      ),
    );
  }
}
