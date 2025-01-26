import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/models/event_model.dart';
import 'package:todo/screens/event_details.dart';

class ItemList extends StatelessWidget {
  EventModel model;
  Function onTab;

  ItemList({required this.model,required this.onTab,super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        model.isDone?
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.3),  // أو أي لون تفضله عند إتمام الـ event
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset("assets/images/${model.category}.png")),
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
                    Expanded(child: Text("${model.title}",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w700),)),
                    GestureDetector(
                        onTap: (){
                           Navigator.pushNamed((context), EventDetails.routeName,arguments: model.id);
                        },
                        child: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                    SizedBox(width: 12.h,),
                    GestureDetector(
                        onTap:()=>FirebaseManager.deleteEvent(model.id),
                        child: Icon(Icons.delete,color: Theme.of(context).primaryColor,)),
                    SizedBox(width: 12.h,),
                    GestureDetector(
                        onTap: (){
                          model.isDone = !model.isDone;
                          FirebaseManager.update(model); // تأكد من أنك تحدث الـ event في قاعدة البيانات
                          onTab(model.isDone);
                          },
                        child: Icon(Icons.check_box_rounded,color: Theme.of(context).primaryColor,)),
                    GestureDetector(
                        onTap: (){
                          model.isFavorite = !model.isFavorite;
                          FirebaseManager.update(model); // تأكد من أنك تحدث الـ event في قاعدة البيانات
                          onTab(model.isFavorite);
                        },
                        child: Icon(model.isFavorite?Icons.favorite:Icons.favorite_border,color: Theme.of(context).primaryColor,)),

                  ],
                ),
              )
                    ],
          ),
        ):
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset("assets/images/${model.category}.png")),
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
                  Expanded(child: Text("${model.title}",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w700),)),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed((context), EventDetails.routeName,arguments: model.id);
                      },
                      child: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                  SizedBox(width: 12.h,),
                  GestureDetector(
                      onTap:()=>FirebaseManager.deleteEvent(model.id),
                      child: Icon(Icons.delete,color: Theme.of(context).primaryColor,)),
                  SizedBox(width: 12.h,),
                  GestureDetector(
                      onTap: (){
                        model.isDone = !model.isDone;
                        FirebaseManager.update(model); // تأكد من أنك تحدث الـ event في قاعدة البيانات
                        onTab(model.isDone);
                      },
                      child: Icon(Icons.check_box_outlined,color: Theme.of(context).primaryColor,))

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
            Text(  "${convertMillisecondsToDateTime(model.date).split(",")[0].substring(8,10)}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
              Text(  "${convertMillisecondsToDateTime(model.date).split(",")[2].substring(0,3)}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
            ],
        ),
        ),
      ],
    );
  }
  String convertMillisecondsToDateTime(int milliseconds) {
    // Convert milliseconds to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    // Format the date to a readable format
    DateFormat formattedDate = DateFormat('yyyy-MM-dd,EEE,MMMM');
    String formatDate=formattedDate.format(dateTime);
    return formatDate;

  }
}
