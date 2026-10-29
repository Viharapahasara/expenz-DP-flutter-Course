import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class PregressBar extends StatelessWidget {
  final String title;
  final double value;
  final double total;
  final Color color;
  final Duration animationDuration;

  const PregressBar({
    super.key,
    required this.title,
    required this.value,
    required this.total,
    required this.color,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  Widget build(BuildContext context) {
    final safeRatio = value.isFinite && total.isFinite && total > 0
        ? (value / total).clamp(0.0, 1.0).toDouble()
        : 0.0;
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                          Icon(Icons.circle, color: color, size: 18),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "\$$value",
                    style: const TextStyle(
                      color: kBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: safeRatio),
                duration: animationDuration,
                curve: Curves.easeOutCubic,
                builder: (BuildContext context, double animatedRatio, Widget? child) {
                  return LinearProgressIndicator(
                    value: animatedRatio,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: kLightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
