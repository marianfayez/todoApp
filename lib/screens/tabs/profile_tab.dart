import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/screens/log_in.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: InkWell(
            onTap: (){
              FirebaseManager.logOut().then((_){
                Navigator.pushNamedAndRemoveUntil(context, LogInScreen.routeName, (route) => false,);
              });
            },
            child:
          Text("Sign Out")),
      ),
    );
  }
}
