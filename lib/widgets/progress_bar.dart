import 'package:flutter/material.dart';

linearProgressBar() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 14),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
    ),
  );
}
