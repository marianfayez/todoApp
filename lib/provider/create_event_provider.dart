import 'package:flutter/material.dart';

class CreateEventProvider extends ChangeNotifier{

  List <String> eventCategories=[
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
  DateTime selectedDate = DateTime.now();

  changeDate(DateTime date){
    selectedDate=date;
    notifyListeners();
  }

  String get selectedCategoryName => eventCategories[selectedCategory];

  changeCategory(int index){
    selectedCategory=index;
    notifyListeners();
  }
}
