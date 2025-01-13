import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String text;
  Icon icon;
   CustomTextField({required this.text,required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return   TextField(
      decoration: InputDecoration(
          labelText: text,
          labelStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).focusColor),
          prefixIcon: icon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  width: 1, color: Theme.of(context).focusColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  width: 1, color: Theme.of(context).focusColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  width: 1, color: Theme.of(context).focusColor))),
    );
  }
}
