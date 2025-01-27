import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final modelId = ModalRoute.of(context)?.settings!.arguments as String;

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CreateEventProvider();
      },
      builder: (context, child){
        return ChangeNotifierProvider(
          create: (BuildContext context) {
            return CreateEventProvider();
          },
          builder: (context,child){
            var provider = Provider.of<CreateEventProvider>(context);

            return Scaffold(
              appBar: AppBar(title:const Text("Edit Event",)),
              body:
              StreamBuilder<DocumentSnapshot<EventModel>> (
                stream: FirebaseManager.getEventId(modelId),
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
                                "assets/images/${provider.eventCategories[provider.selectedCategory]}.png",
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
                          SizedBox(
                            height: 16.h,
                          ),
                          Text("Title",style: Theme.of(context).textTheme.titleSmall,),
                          SizedBox(height: 8.h,),
                      TextFormField(
                        controller:titleController ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Title is required";
                          }
                          return null;
                          },

                        decoration: InputDecoration(
                            hintText: snapshot.data!.data()!.title,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Theme.of(context).focusColor),
                            prefixIcon: Icon(Icons.edit_note_rounded),
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
                      ),
                          SizedBox(height: 8.h,),
                          Text("Description",style: Theme.of(context).textTheme.titleSmall,),
                          SizedBox(height: 8.h,),
                          TextField(
                            maxLines: 4,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                hintText: snapshot.data!.data()!.description,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Theme.of(context).focusColor),
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
                          ),
                          SizedBox(height: 18.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/icons/event.png",color: Colors.black,),
                              InkWell(
                                  onTap: () async {
                                    var date = await showDatePicker(context: context,
                                        initialDate: provider.selectedDate,
                                        firstDate: DateTime.now().subtract(Duration(days: 365))
                                        ,lastDate: DateTime.now().add(Duration(days: 365)));
                                    if(date!=null){
                                      provider.changeDate(date);
                                    }
                                  },
                                  child: Text(provider.selectedDate.toString().substring(0,10),style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor),))
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),

              bottomNavigationBar:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: ()async {
                    showDialog(context: context, builder: (context){
                      return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                    });
                    EventModel model =EventModel(
                      id: modelId,
                        category: provider.selectedCategoryName,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: provider.selectedDate.millisecondsSinceEpoch,
                        userId: FirebaseAuth.instance.currentUser!.uid);
                    await Future.delayed(Duration(seconds: 3));
                    FirebaseManager.update(model);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      )
                  ),
                  child: Text("Edit Event",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
                ),
              ),

            );
          },
        );
      },
    );
  }}
