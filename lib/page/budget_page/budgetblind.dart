import 'package:expenz/constants/colors.dart';
import 'package:expenz/page/budget_page/widget/pregress_bar.dart';
import 'package:flutter/material.dart';
import 'package:chartify/chartify.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class Budgetblind extends StatefulWidget {
  const new({super.key});

  @override
  State<Budgetblind> createState() => _BudgetblindState();
}

class _BudgetblindState extends State<Budgetblind> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top*2,
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                    
              BoxShadow(
                color: kGrey.withValues(alpha: 0.2),
                offset: const Offset(0,4),
                spreadRadius: 2,
                blurRadius: 8,
                    
              )]

            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: PieChart(
                data: PieChartData(
                  sections: [
                    PieSection(
              value: 20,
              label: 'Mobile',
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              shadowElevation: 6,
                    ),
                    const PieSection(value: 30, label: 'Desktop', color: Color(0xFF10B981)),
                    const PieSection(value: 20, label: 'Tablet', color: Color(0xFFF59E0B)),
                    const PieSection(value: 15, label: 'Other', color: Color(0xFF8B5CF6)),
                  ],
                  holeRadius: 0.5,         // 0 = pie, >0 = donut
                  segmentGap: 3,
                  cornerRadius: 4,
                  enableShadows: true,
                  showLabels: true,
                  labelPosition: PieLabelPosition.outside,
                  labelConnector: PieLabelConnector.elbow,
                ),
                // Optional center widget for donut charts
                centerWidget: const Text('Total\n100', textAlign: TextAlign.center),
                tooltip: const TooltipConfig(enabled: true),
                animation: const ChartAnimation(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),
          ),
        ),

        SimpleAnimationProgressBar(
    height: 30,
    width: 300,
    backgroundColor: Colors.grey.shade800,
    foregroundColor: Colors.purple,
    ratio: 0.5,
    direction: Axis.horizontal,
    curve: Curves.fastLinearToSlowEaseIn,
    duration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(10),
    progressBarShadow: [
      BoxShadow(
        color: Colors.pink,
        offset: const Offset(
          5.0,
          5.0,
        ),
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ),
    ],
),

PregressBar(),

      ],
    ) ;
  }
}