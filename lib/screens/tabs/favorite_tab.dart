import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/main.dart';
import 'package:todo/models/event_model.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/widgets/category_list.dart';
import 'package:todo/widgets/item_list.dart';
import '../../provider/create_event_provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<FavoriteTab> {
  List <String> eventCategories=[
    "All",
    "Birthday",
    "Book club",
    "Eating",
    "Exhibition",
    "Gaming",
    "Holiday",
    "Meeting",
    "Sport",
    "Workshop"
  ];

  int selectedCategory=0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CreateEventProvider();
      },
      builder: (context,child){
        var userProvider = Provider.of<UserProvider>(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 200.h,
            backgroundColor: Theme.of(context).primaryColor,
            leadingWidth: 0,
            leading: const SizedBox(),
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
                            Text("${userProvider.userModel?.name}",style: Theme.of(context).textTheme.headlineMedium,),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.wb_sunny_outlined,color: Colors.white,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Text("EN",style: Theme.of(context).textTheme.titleSmall,),
                    )
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,color: Colors.white,),
                    SizedBox(width: 4.w,),
                    Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineSmall,)
                  ],
                ),
                SizedBox(height: 24.h,),
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return  InkWell(
                          onTap: () {

                            selectedCategory = index;
                            setState(() {
                            });
                          },
                          child: CategoryList(
                            text:eventCategories[index],
                            isSelected: selectedCategory == index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.w,
                      ),
                      itemCount: eventCategories.length),
                ),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot<EventModel>> (
            stream: FirebaseManager.getEvent(eventCategories[selectedCategory]),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text("Something went wrong"));
              }
              if(snapshot.data!.size ==0 ){
                return const Center(child: Text("No Data Found"));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(itemBuilder:
                    (context,index){
                  return
                    ItemList(model: snapshot.data!.docs[index].data(),
                      onTab: (isFavorite){

                      },);
                },
                    separatorBuilder: (context,index)=>SizedBox(height: 16.h,), itemCount: snapshot.data?.docs.length??0),
              );
            },
          ),
        );
      },
    );
  }
}
