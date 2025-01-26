import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/create_event.dart';
import 'package:todo/screens/edit_event.dart';
import 'package:todo/screens/event_details.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/introduction_screen.dart';
import 'package:todo/screens/log_in.dart';
import 'package:todo/screens/onboarding_screen.dart';
import 'package:todo/screens/register_screen.dart';
import 'package:todo/theme/dark_theme.dart';
import 'package:todo/theme/light__theme.dart';
import 'package:todo/theme/my_theme.dart';
import 'cache_helper/cache_helper.dart';
import 'firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseFirestore.instance.enableNetwork();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>MyProvider()),
          ChangeNotifierProvider(create: (context)=>UserProvider())
              ],
        child: EasyLocalization(
            supportedLocales: [Locale('en'), Locale('ar')],
            path: 'assets/translations', // <-- change the path of the translation files
            fallbackLocale: Locale('en'),
            child: MyApp()),
      ));

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    var userProvider =Provider.of<UserProvider>(context);
    MyTheme light =LightTheme();
    MyTheme dark =DarkTheme();
    return  ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ( context,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute:
        userProvider.currentUser!=null?
        HomeScreen.routeName : LogInScreen.routeName,
        theme: light.themeData,
        darkTheme: dark.themeData,
        themeMode: provider.themeMode,
        routes: {
          IntroductionScreen.routeName:(context)=>IntroductionScreen(),
          OnboardingScreen.routeName:(context)=>OnboardingScreen(),
          LogInScreen.routeName:(context)=>LogInScreen(),
          RegisterScreen.routeName:(context)=>RegisterScreen(),
          HomeScreen.routeName:(context)=>HomeScreen(),
          CreateEvent.routeName:(context)=>CreateEvent(),
          EventDetails.routeName:(context)=>EventDetails(),
          EditEvent.routeName:(context)=>EditEvent(),

        },
      
      ),
    );

  }
}

