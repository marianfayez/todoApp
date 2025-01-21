import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/log_in.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "RegisterScreen";

  RegisterScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
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
                SizedBox(height: 16.h),
                TextFormField(
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
                      labelText: "Name",
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
                SizedBox(height: 16.h),
                TextFormField(
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
                      labelText: "Email",
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
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password must be more than 6 digits";
                    }
                    return null;
                  },
                  onChanged:(value) {
                    formKey.currentState!.validate();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).focusColor),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility_off),
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
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Repassword is required";
                    } else if (value.length < 6) {
                      return "Password must be more than 6 digits";
                    }
                    else if(passwordController.text!=value){
                      return "Password don't match";
                    }
                    return null;
                  },
                  onChanged:(value) {
                    formKey.currentState!.validate();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Re Password",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).focusColor),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility_off),
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
                SizedBox(
                  height: 24.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      FirebaseManager.createAccount(
                          emailController.text, passwordController.text,nameController.text,
                          (){
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false,);
                          },(){
                            showDialog(context: context,
                                builder: (context) => const AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  title: Center(child:
                                  CircularProgressIndicator()),
                                ),);
                      },(message){
                            Navigator.pop(context);
                            showDialog(context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Something went wrong"),
                                  content: Text(message),
                                  actions: [
                                    ElevatedButton(onPressed: (){Navigator.pop(context);},
                                        child: const Text("Ok"))
                                  ],
                                ),);
                      });
                    };
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LogInScreen.routeName);
                  },
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Already Have Account ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.black)),
                          TextSpan(
                              text: "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
