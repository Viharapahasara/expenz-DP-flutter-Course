import 'package:expenz/constants/colors.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screen/onboard/fontpage.dart';
import 'package:expenz/screen/onboard/shairdonboardind.dart';
import 'package:expenz/screen/onboard/widget/custombutton.dart';
import 'package:expenz/screen/userdata_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page Contraler
  final PageController _controller = PageController();
  bool showDtailsPAge = false;
  bool showDot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                //on boarding screen
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    showDot = index == 0;
                    showDtailsPAge = index == 3;
                    if (showDtailsPAge) {
                      setState(() {});
                    } else
                      setState(() {});
                  },
                  children: [
                    Fontpage(),

                    Shairdonboardind(
                      title: OnboardingData.onboardingDataList[0].title,
                      imagePath: OnboardingData.onboardingDataList[0].imagePath,
                      description:
                          OnboardingData.onboardingDataList[0].description,
                    ),

                    Shairdonboardind(
                      title: OnboardingData.onboardingDataList[2].title,
                      imagePath: OnboardingData.onboardingDataList[2].imagePath,
                      description:
                          OnboardingData.onboardingDataList[2].description,
                    ),

                    Shairdonboardind(
                      title: OnboardingData.onboardingDataList[1].title,
                      imagePath: OnboardingData.onboardingDataList[1].imagePath,
                      description:
                          OnboardingData.onboardingDataList[1].description,
                    ),
                  ],
                ),

                //page indicator
                Container(
                  alignment: const Alignment(0, 0.7),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: JumpingDotEffect(
                      activeDotColor: kMainColor,
                      dotColor:  kGrey,
                    ),
                  ),
                ),

                //NAvigation Button
                Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Custombutton(
                     
                      buttonName: showDtailsPAge ? "Get Started" : "Next",
                      color: kMainColor,
                      next: () {
                        if (showDtailsPAge) {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserdataScreen(),
                            ),
                          );
                        } else {
                          
                          _controller.animateToPage(
                            _controller.page!.toInt() + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutQuart,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
