import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String text;
  Icon icon;
  Function validator;
  Function onChange;

  TextEditingController controller;
   CustomTextField({required this.text,required this.validator,required this.onChange,required this.icon,required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller:controller ,
      validator: (value) {
        validator(value);
      },
      onChanged:(value) {
        onChange();
      },
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
