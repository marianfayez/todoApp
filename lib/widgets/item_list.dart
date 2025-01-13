import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset("assets/images/Birthday.png")),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 8.h),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("This is a Birthday Party ",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w700),),
                  Icon(Icons.favorite_border,color: Theme.of(context).primaryColor,)
                ],
              ),
            )
                  ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8.h,left: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration:BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(8.r)
          ),
          child: Column(
            children: [
            Text(  "21\nNov",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
            //Text("Nov",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor),),
          ],
        ),
        ),
      ],
    );
  }
}
