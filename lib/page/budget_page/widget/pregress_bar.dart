import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class PregressBar extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),

         boxShadow: [
                    
              BoxShadow(
                color: kGrey.withValues(alpha: 0.2),
                offset: const Offset(0,4),
                spreadRadius: 2,
                blurRadius: 8,
                    
              )]
      ),

      child: Column(children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kLightGrey,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: kGrey,
                  width: 1
                )
              ),
              child: Row(
                children: [
                  Icon(Icons.circle,
                  color: Colors.orange,
                  size: 18,),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Shopping",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),),
                  )
                ],
              ),
            )
          ],
        )
      ],),
    );
  }
}