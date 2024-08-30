import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    this.textEditingController,
    this.iconData,
    this.hintText,
    this.isObsecre,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefix: Icon(
            widget.iconData,
            color: Colors.purpleAccent,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
