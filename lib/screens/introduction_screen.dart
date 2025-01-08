import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/onboarding_screen.dart';
import 'package:todo/theme/light__theme.dart';
import 'package:todo/theme/my_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class IntroductionScreen extends StatelessWidget {
  static const String routeName="Introduction Screen";
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return Scaffold(
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, OnboardingScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              )
          ),
          child: Text("lets_start".tr(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
        ),
      ),
      appBar: AppBar(
        title: Image.asset("assets/images/evently_logo.png"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/introduction_img.png",width: double.infinity,fit: BoxFit.fill,),
            SizedBox(height: 20,),
            Text("introduction_title".tr(),style:Theme.of(context).textTheme.titleMedium,),
            SizedBox(height: 20,),
            Text("description".tr()
              ,style:Theme.of(context).textTheme.titleSmall,),
            SizedBox(height: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("language".tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                  ToggleSwitch(
                    minWidth: 50,
                    initialLabelIndex: context.locale.toString()=="en"?0:1,
                    cornerRadius: 40.0,
                    inactiveBgColor: Theme.of(context).hintColor,
                    totalSwitches: 2,
                    activeBgColor: [Theme.of(context).primaryColor],
                    activeBorders: [
                      Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3.0,
                      ),
                    ],
                    labels: ["english","arabic"],
                    radiusStyle: true,
                    customWidgets: [
                      Image.asset("assets/images/english.png"), Image.asset("assets/images/arabic.png")],
                    onToggle: (index) {
                      if(index==1){
                        context.setLocale(Locale('ar'));
                      }else{
                        context.setLocale(Locale('en'));
                      }
                      print('switched to: $index');
                    },
                  ),],),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("theme".tr(),style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                  ToggleSwitch(
                    minWidth: 50,
                    initialLabelIndex: provider.themeMode==ThemeMode.light?0:1,
                    cornerRadius: 40.0,
                    inactiveBgColor: Theme.of(context).hintColor,
                    totalSwitches: 2,
                    activeBgColor: [Theme.of(context).primaryColor],
                    activeBorders: [
                      Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3.0,
                      ),
                    ],
                    labels: ["light","dark"],
                    radiusStyle: true,
                    customWidgets: [Image.asset("assets/images/sun.png",
                      color:provider.themeMode==ThemeMode.light? Colors.black:Colors.white,), Icon(Icons.dark_mode_outlined)],
                    onToggle: (index) {
                      provider.changeTheme();
                      print('switched to: $index');
                    },
                  ),],),
            ),
            
          ],
        ),
      )
    );
  }
}
