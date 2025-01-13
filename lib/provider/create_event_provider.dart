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

  changeCategory(int index){
    selectedCategory=index;
    notifyListeners();
  }
}
