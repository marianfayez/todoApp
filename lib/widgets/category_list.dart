import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  String text;
  bool isSelected;
  CategoryList({required this.text,required this.isSelected,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color:isSelected? Theme.of(context).secondaryHeaderColor:Colors.transparent,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color:Theme.of(context).secondaryHeaderColor)),
        child: Row(
          children: [
            Text(text,style: TextStyle(
              fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected?Theme.of(context).primaryColor:Theme.of(context).secondaryHeaderColor),),
          ],
        ));
  }
}
