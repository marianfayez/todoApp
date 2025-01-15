import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/main.dart';
import 'package:todo/screens/log_in.dart';
import 'package:todo/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "RegisterScreen";

   RegisterScreen({super.key});
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var rePasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.asset("assets/images/Logo.png")),
            SizedBox(height: 16.h),
            CustomTextField(text: "Name",icon: Icon(Icons.person),controller: nameController,),
            SizedBox(height: 16.h),
            CustomTextField(text: "Email",icon: Icon(Icons.email),controller: emailController,),
            SizedBox(
              height: 16.h,
            ),
            TextField(
              controller: passwordController,
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
            TextField(
              controller: rePasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Re Password",
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
            SizedBox(height: 24.h,),
            ElevatedButton(
              onPressed: (){
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              child: Text("Create Account",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 24.h,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, LogInScreen.routeName);
              },
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                children: [
                  TextSpan(text: "Already Have Account ?",
                      style:
                      Theme.of(context).textTheme.titleSmall!.copyWith(color:Colors.black)),
                  TextSpan(text: "Login",
                      style:
                      Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor,decoration: TextDecoration.underline,fontWeight: FontWeight.bold)),
                ],
              )),
            ),

          ],
        ),
      ),
    );
  }
}
