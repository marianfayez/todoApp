import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/main.dart';
import 'package:todo/widgets/item_list.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 210.h,
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 0,
        leading: SizedBox(),
        shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(24.r),bottomLeft: Radius.circular(24.r))),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back ✨",style: Theme.of(context).textTheme.headlineSmall,),
                        Text("John Safwat",style: Theme.of(context).textTheme.headlineMedium,),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.wb_sunny_outlined,color: Colors.white,),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Text("EN",style: Theme.of(context).textTheme.titleSmall,),
                )
              ],
            ),
            SizedBox(height: 8.h,),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(itemBuilder: (context,index)=>ItemList(),
            separatorBuilder: (context,index)=>SizedBox(height: 16.h,), itemCount: 20),
      ),
    );
  }
}
