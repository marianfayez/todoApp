import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/models/event_model.dart';

import '../provider/create_event_provider.dart';
import '../widgets/category_event_item.dart';

class EditEvent extends StatelessWidget {
  static String routeName = " EditEvent";

  EditEvent({super.key});

  var titleController =TextEditingController();
  var descriptionController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)?.settings!.arguments as String;

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CreateEventProvider();
      },
      builder: (context, child){
        var provider = Provider.of<CreateEventProvider>(context);
        return Scaffold(
          appBar: AppBar(title:Text("Edit Event",)),
          body:
          StreamBuilder<DocumentSnapshot<EventModel>> (
            stream: FirebaseManager.getEventId(model),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text("Something went wrong"));
              }
              DateTime date = DateTime.fromMillisecondsSinceEpoch(snapshot.data!.data()!.date);
              String formattedDate = DateFormat('yyyy-MM-dd').format(date);

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset(
                            "assets/images/${snapshot.data!.data()!.category}.png",
                            height: 220.h,fit: BoxFit.fill,
                          )),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                provider.changeCategory(index);
                              },
                              child: CategoryEventItem(
                                text: provider.eventCategories[index],
                                isSelected: provider.selectedCategory == index,
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10.w,
                            ),
                            itemCount: provider.eventCategories.length),
                      ),
                      Row(
                        children: [
                          Text("Title",style:Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 16.w,),
                          Text(snapshot.data!.data()!.title,style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Row(
                        children: [
                          Text("Description",style:Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 16.w,),
                          Text(snapshot.data!.data()!.description,style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Row(
                        children: [
                          Text("Date",style:Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 16.w,),

                          Text(formattedDate,style: Theme.of(context).textTheme.titleSmall,),
                        ],)
                    ],
                  ),
                ),
              );
            },
          ),

          bottomNavigationBar:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              child: Text("Edit",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
            ),
          ),


        );
      },
    );
  }}
