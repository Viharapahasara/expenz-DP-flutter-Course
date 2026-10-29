import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icone;
  final VoidCallback? onTap;

  const WidgetCard({
    super.key,
    required this.color,
    required this.title,
    required this.icone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //color: kGrey
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icone, color: color, size: 35),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
