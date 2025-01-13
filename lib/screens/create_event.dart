import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/provider/create_event_provider.dart';
import 'package:todo/widgets/category_event_item.dart';
import 'package:todo/widgets/custom_text_field.dart';

class CreateEvent extends StatelessWidget {
  static String routeName = "CreateEvent";
  CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CreateEventProvider();
      },
      builder: (context, child) {
        var provider = Provider.of<CreateEventProvider>(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "Create Event",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 16.h,),
                Text("Title",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 8.h,),
                CustomTextField(text: "Event Title", icon: Icon(Icons.edit_note_rounded)),
                SizedBox(height: 8.h,),
                Text("Description",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 8.h,),

                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: "Event Description",
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
