import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/edit_profile.dart';

import '../../firebase/firebase_manager.dart';
import '../../provider/auth_provider.dart';
import '../../provider/my_provider.dart';
import '../log_in.dart';


class ProfileTab extends StatefulWidget {

   ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();
  String _selectedLanguage = 'Arabic'; // Default text
  String _selectedTheme = 'Light'; // Default text

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var provider =Provider.of<MyProvider>(context);

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
               Text("Language",style:Theme.of(context).textTheme.titleMedium?.copyWith(color:
               provider.themeMode==ThemeMode.light?Colors.black:Colors.white)),
               SizedBox(width: 16.w,),
              PopupMenuButton<String>(
                onSelected: (String value){
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
                itemBuilder: (context){
                return[
                   PopupMenuItem<String>(value: 'Arabic',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width, // Ensure full width
                      child: const Text('Arabic'),
                    ),),
                  const PopupMenuDivider(
                    height: 1,
                  ),
                  PopupMenuItem<String>(value: 'English',
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                    child: const Text('English'),))
                ];
              },
                color: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                offset: const Offset(0, 8), // You can adjust this to position the menu vertically
                child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                    border:Border.all(color: provider.themeMode==ThemeMode.light?Colors.black:Theme.of(context).primaryColor) ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                     _selectedLanguage, // The text that the user taps
                      style:Theme.of(context).textTheme.titleMedium),
                     Icon(Icons.arrow_drop_down,color: provider.themeMode==ThemeMode.light?Colors.black:Theme.of(context).primaryColor
                    )
                  ],
                ),
                  ),),
              Text("Theme",style:Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: provider.themeMode==ThemeMode.light?Colors.black:Colors.white)),
              PopupMenuButton<String>(
                onSelected: (String value){
                  setState(() {
                    _selectedTheme=value;

                  });
                },
                itemBuilder: (context){
                  return[
                    PopupMenuItem<String>(value: 'Light',
                      onTap: (){
                        provider.themeLight();
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width, // Ensure full width
                        child: const Text('Light'),
                      ),),
                    const PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem<String>(value: 'Dark',
                        onTap: (){
                          provider.themeDark();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Text('Dark'),))
                  ];
                },
                color: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  side:const  BorderSide(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                offset:const  Offset(0, 8), // You can adjust this to position the menu vertically
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                      border:Border.all(color: provider.themeMode==ThemeMode.light?Colors.black:Theme.of(context).primaryColor) ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          _selectedTheme, // The text that the user taps
                          style:Theme.of(context).textTheme.titleMedium),
                  Icon(Icons.arrow_drop_down,color: provider.themeMode==ThemeMode.light?Colors.black:Theme.of(context).primaryColor)
                    ],
                  ),
                ),),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, EditProfile.routeName,arguments: userProvider.userModel?.id);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text(
                  "Edit Profile",
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
