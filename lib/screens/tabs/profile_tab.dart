import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/edit_profile.dart';

import '../../firebase/firebase_manager.dart';
import '../../provider/auth_provider.dart';
import '../log_in.dart';


class ProfileTab extends StatelessWidget {

   ProfileTab({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 200.h,
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 0,
        leading: const SizedBox(),
        shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64.r))),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/profile.png"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${userProvider.userModel?.name}",style: Theme.of(context).textTheme.headlineMedium,),
                        SizedBox(height: 12.h,),
                        Text("${userProvider.userModel?.email}",style: Theme.of(context).textTheme.headlineSmall,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text("Language",style:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
               SizedBox(width: 16.w,),
              PopupMenuButton<String>(itemBuilder: (context){
                return[
                  const PopupMenuItem<String>(value: 'Option 1',
                    child: Text('Arabic'),),
                  const PopupMenuItem<String>(value: 'Option 1',
                    child: Text('English'),)
                ];
              },
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                    border:Border.all(color: Colors.black) ),
                child:  Text(
                  'Arabic', // The text that the user taps
                  style:Theme.of(context).textTheme.titleMedium),
                  ),),


              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, EditProfile.routeName);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text(
                  "Edit",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom: 30.0,right: 16,left: 16),
        child: ElevatedButton(
          onPressed: () {
            FirebaseManager.logOut().then((_){
              Navigator.pushNamedAndRemoveUntil(context, LogInScreen.routeName, (route) => false,);
            });
          },
          style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              backgroundColor: const Color(0xFFFF5659),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Row(
            children: [
              const Icon(Icons.logout,color: Colors.white,),
              SizedBox(width: 8.h,),
              Text(
                "Logout",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

      ),

    );
  }
}

/*Center(
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
);*/
