import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/models/event_model.dart';

import '../../widgets/item_list.dart';

class FavoriteTab extends StatelessWidget {

  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:const Text(" Favorite Event",)),
      body: StreamBuilder<QuerySnapshot<EventModel>> (
        stream: FirebaseManager.getEventByFav(true),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorite events found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(itemBuilder:
                (context,index){
              return
                ItemList(model: snapshot.data!.docs[index].data(),
                  );
            },
                separatorBuilder: (context,index)=>SizedBox(height: 16.h,), itemCount: snapshot.data?.docs.length??0),
          );
        },
      ),



    );
  }}
