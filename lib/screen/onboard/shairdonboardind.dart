import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';
import 'package:flutter/material.dart';

class Shairdonboardind extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  const Shairdonboardind({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kdefaultpadding),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath,
          width: 300,
          fit: BoxFit.cover,),
      
          const  SizedBox(height: 20,),
      
          Text(title,style: TextStyle(
            fontSize: 28,
            fontWeight:const FontWeight(800),
          ),),
      
           const  SizedBox(height: 20,),
      
          Text(description,style: const TextStyle(
            fontSize: 16,
            color: kGrey,
            fontWeight: FontWeight(500),
          ),)
          
        ],
      ),
    );
  }
}
