import 'package:flutter/material.dart';
import 'package:todo/screens/create_event.dart';
import 'package:todo/screens/tabs/favorite_tab.dart';
import 'package:todo/screens/tabs/home_tab.dart';
import 'package:todo/screens/tabs/map_tab.dart';
import 'package:todo/screens/tabs/profile_tab.dart';
import 'package:todo/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomeScreen";
   HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(onChange: (index){
        selectedIndex=index;
        setState(() {

        });
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, CreateEvent.routeName);
        },
      child: Icon(Icons.add,color: Colors.white,),),
      body: tabs[selectedIndex],
    );
  }

  List<Widget>tabs=[
    HomeTab(),
    MapTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

}
