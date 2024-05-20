//  ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'package:reliby/view/home/home_view.dart';
import 'package:reliby/view/login/sign_in_view.dart';
import 'package:reliby/view/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var loading = 0;
  double _fontSize = 2.5;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> animation1;

  void navigate() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var email = preferences.getString("email");
      if (email != null && email != "") {
        setState(() {
          loading = 1;
        });
      } else {
        setState(() {
          loading = 2;
        });
      }
    } catch (ex) {
      setState(() {
        loading = 2;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 6620))
      ..repeat();

    loading = 0;
    navigate();
    _controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller1, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller1.forward();

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _fontSize = 1.25;
      });
    });

    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        Navigator.pushReplacement(context,
            PageTransition(loading == 1 ? HomeView() : OnboardingView()));
        _controller2.dispose();
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final double screenHeigh = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 23, 185, 64),
                Color.fromARGB(255, 51, 153, 26),
                Color.fromARGB(255, 19, 145, 50),
                Color.fromARGB(255, 14, 148, 74),
                Color.fromARGB(255, 5, 48, 22),
              ],
            )),
            child: Column(
              children: [
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: screenHeigh / _fontSize,
                  ),
                ),
                AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: _textOpacity,
                    child: Container(
                      //  width: screenWidth/7,
                      height: screenHeigh / 7,
                      child: Text(
                        "REliby",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: screenWidth / _containerSize,
                  width: screenWidth / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedContainer(
                    width: screenWidth / 30,
                    duration: const Duration(milliseconds: 4000),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _controller2,
                        builder: (_, child) {
                          return Transform.scale(
                            scale: 20,
                            // angle: _controller2.value * -15 * math.pi,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          "assets/img/splashimg2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;
  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
