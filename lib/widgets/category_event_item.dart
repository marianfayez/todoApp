import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryEventItem extends StatelessWidget {
  String text;
  bool isSelected;
   CategoryEventItem({required this.text,required this.isSelected,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color:isSelected? Theme.of(context).primaryColor:Colors.transparent,
            borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color:Theme.of(context).primaryColor)),
        child: Row(
          children: [
            Text(text,style: TextStyle(
              fontWeight: FontWeight.w700,
                color: isSelected?Colors.white:Theme.of(context).primaryColor),),
          ],
        ));
  }
}
