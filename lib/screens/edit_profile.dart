import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/home_screen.dart';

import '../../provider/auth_provider.dart';
import '../firebase/firebase_manager.dart';


class EditProfile extends StatelessWidget {
  static String routeName = " EditProfile";

  EditProfile({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final modelId = ModalRoute.of(context)?.settings!.arguments as String;
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Image.asset("assets/images/Logo.png")),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name",style:Theme.of(context).textTheme.titleMedium),
                    SizedBox(width: 16.w,),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                        onChanged:(value) {
                          formKey.currentState!.validate();
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            labelText: "${userProvider.userModel?.name}",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Theme.of(context).focusColor),
                            prefixIcon: const Icon(Icons.person),
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
                      ),
                    ),
                  ],),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email",style:Theme.of(context).textTheme.titleMedium),
                    SizedBox(width: 16.w,),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);

                          if (!emailValid) {
                            return "Email not valid";
                          }
                          return null;
                        },
                        controller: emailController,
                        onChanged:(value) {
                          formKey.currentState!.validate();
                        },
                        decoration: InputDecoration(
                            labelText: "${userProvider.userModel?.email}",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Theme.of(context).focusColor),
                            prefixIcon: const Icon(Icons.email),
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
                      ),
                    ),

                  ],),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: ()async {
            showDialog(context: context, builder: (context){
              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
            });
            UserModel model =UserModel(
              name: nameController.text,
              email: emailController.text,
              id: modelId,
              createAt:DateTime.now().millisecondsSinceEpoch
            );
            await Future.delayed(Duration(seconds: 3));
            FirebaseManager.updateUser(model);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              )
          ),
          child: Text("Edit Profile",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
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
