import 'package:expenz/page/home.dart';
import 'package:expenz/screen/onboard/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {

  final bool showMAinScreen;

  const Wrapper({super.key, required this.showMAinScreen});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.showMAinScreen 
    ? Home() 
    : OnboardingScreen();
  }
}