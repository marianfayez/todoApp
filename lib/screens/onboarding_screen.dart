import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../cache_helper/cache_helper.dart';

class OnboardingScreen extends StatelessWidget {
  static String routeName="onBoarding";
  const OnboardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,color: Color(0xFF5669FF)),
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Color(0xFFF2FEFF),
        imagePadding: EdgeInsets.zero,
        imageFlex:2

    );
    return IntroductionScreen(
      globalBackgroundColor:  Color(0xFFF2FEFF),
      globalHeader: _buildImage("evently_logo.png"),
      done: Text("Done",style: Theme.of(context).textTheme.titleSmall),
      showDoneButton: true,
      onDone:(){
        CacheHelper.saveEligibility();
      },
      next: Text("Next",style: Theme.of(context).textTheme.titleSmall,),
      showNextButton: true,
      dotsDecorator: DotsDecorator(color: Color(0xFF707070),
          activeColor: Color(0xFFFFD482)),
      skip: Text("Skip",style: Theme.of(context).textTheme.titleSmall),
      showSkipButton: true,
      onSkip: (){
      },
      pages: [
        PageViewModel(
          title: "Find Events That Inspire You",
          body: "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. "
              "Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          image: _buildImage('onboarding1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Effortless Event Planning",
          body: "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. "
              "Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
          image: _buildImage('onboarding2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect with Friends & Share Moments",
          body: "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. "
              "Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
          image: _buildImage('onboarding3.png'),
          decoration: pageDecoration,
        ),

      ],

      //rtl: true, // Display as right-to-left


    );
  }
}
