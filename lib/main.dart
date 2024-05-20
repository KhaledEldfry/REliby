import 'package:reliby/common/color_extenstion.dart';
import 'package:reliby/view/onboarding/onboarding_view.dart';
import 'package:reliby/view/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primaryColor: TColor.primary,

        fontFamily: 'SF Pro Text',
      ),
      home: SplashScreen(),
    );
  }
}
