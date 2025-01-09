import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/introduction_screen.dart';
import 'package:todo/screens/onboarding_screen.dart';
import 'package:todo/theme/dark_theme.dart';
import 'package:todo/theme/light__theme.dart';
import 'package:todo/theme/my_theme.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (context)=>MyProvider(),
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
    MyTheme light =LightTheme();
    MyTheme dark =DarkTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: IntroductionScreen.routeName,
      theme: light.themeData,
      darkTheme: dark.themeData,
      themeMode: provider.themeMode,
      routes: {
        IntroductionScreen.routeName:(context)=>IntroductionScreen(),
    OnboardingScreen.routeName:(context)=>OnboardingScreen()
      },

    );

  }
}

