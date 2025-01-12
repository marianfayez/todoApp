import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  Function onChange;

   BottomNav({required this.onChange,super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value){
          selectedIndex=value;
          setState(() {
          });
          widget.onChange(selectedIndex);
        },

        items:[ BottomNavigationBarItem(icon:
        selectedItemBg(0, Icon(Icons.home),Icon(Icons.home_outlined))
            ,label: "Home"),
          BottomNavigationBarItem(icon:
          selectedItemBg(1, Icon(Icons.location_on),Icon(Icons.location_on_outlined)),label: "Map"),
          BottomNavigationBarItem(icon:
          selectedItemBg(2, Icon(Icons.favorite),Icon(Icons.favorite_border)),label: "Love"),
          BottomNavigationBarItem(icon:
          selectedItemBg(3, Icon(Icons.person_2),Icon(Icons.person_2_outlined)),label: "Profile"),
        ]);
  }

  Widget selectedItemBg(int index, Icon image,Icon image2) {
    return selectedIndex == index
        ? image
        : image2;
  }
}
