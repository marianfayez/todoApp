import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/main.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/register_screen.dart';
import 'package:todo/widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  static String routeName = "LogIn";

  LogInScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(),
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
                CustomTextField(
                  text: "Email",
                  icon: Icon(Icons.email),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  onChange: (){
                    formKey.currentState!.validate();
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    formKey.currentState!.validate();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).focusColor),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility_off),
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
                Text("Forget Password?",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline)),
                SizedBox(
                  height: 24.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseManager.logIn(
                        emailController.text, passwordController.text, () async{
                          await userProvider.initUser();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    }, () {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          backgroundColor: Colors.transparent,
                          title: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }, (message) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Something went wrong"),
                          content: Text(message),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Don’t Have Account ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.black)),
                          TextSpan(
                              text: "Create Account",
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
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 30,
                        endIndent: 20,
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text("Or"),
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 30,
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
