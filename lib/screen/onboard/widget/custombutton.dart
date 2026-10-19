
import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:bounce/bounce.dart';



class Custombutton extends StatelessWidget {

  final String buttonName;
  final Color color;
  final VoidCallback next;

  const Custombutton({super.key, required this.buttonName, required this.color, required this.next});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: () { 
        next();
       },
       duration: const Duration(milliseconds: 110),
      child: Container(
        height: MediaQuery.of(context).size.height*0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
        child: Center(
          child: Text(buttonName,
          style: TextStyle(
             color: kWhite,
             fontSize: 16,
             fontWeight: FontWeight.w600,
          ),),
        ),
      ),
    );
  }
}