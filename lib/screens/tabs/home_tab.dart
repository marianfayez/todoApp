import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/main.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 0,
        leading: SizedBox(),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back ✨",style: Theme.of(context).textTheme.headlineSmall,),
            Text("John Safwat",style: Theme.of(context).textTheme.headlineMedium,)
          ],
        ),
        actions: [
          Icon(Icons.wb_sunny_outlined,color: Colors.white,),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(8.r)),
            child: Text("EN"),
          )
        ],
        bottom: AppBar(
          toolbarHeight: 100.h,
          backgroundColor: Theme.of(context).primaryColor,
          leadingWidth: 0,
          leading: SizedBox(),
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,color: Colors.white,),
                  SizedBox(width: 4.w,),
                  Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineSmall,)
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h),
                height:60.h,color: Colors.red,)
            ],
          ),
        ),
      ),
    );
  }
}
