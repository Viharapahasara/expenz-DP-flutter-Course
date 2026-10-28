import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class PregressBar extends StatelessWidget {
  final String title;
  final double value;
  final double total;
  final Color color;

  const PregressBar({
    super.key,

    required this.title,
    required this.value,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double calculatedRatio = (total == 0) ? 0.0 : (value / total);
    double safeRatio = calculatedRatio.clamp(0.0, 1.0);
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: kGrey.withValues(alpha: 0.2),
              offset: const Offset(0, 4),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kLightGrey,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: kGrey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.circle, color: Colors.orange, size: 18),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Text(
                    "-\$$value",
                    style: TextStyle(
                      color: kRed,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SimpleAnimationProgressBar(
              height: 15,
              width: MediaQuery.of(context).size.width * 0.9,

              backgroundColor: kLightGrey,
              foregroundColor: color,
              ratio: safeRatio,
              direction: Axis.horizontal,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(seconds: 3),
              borderRadius: BorderRadius.circular(10),
              progressBarShadow: [
                BoxShadow(
                  color: kWhite,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
