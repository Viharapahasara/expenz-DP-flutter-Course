import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  final IncomeCategory category;
  final String title;
  final String description;
  final int amount;
  final DateTime date;
  
  const IncomeCard({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        width: double.infinity,
//height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWhite,
          boxShadow: [
              BoxShadow(
                color: kGrey.withValues(alpha: 0.2),
                offset: const Offset(0,4),
                spreadRadius: 2,
                blurRadius: 8,
        
              )
            ]
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: incomeCatagoryColor[category]?.withValues(alpha: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(incomeCatagoryImages[category] ?? 'assets/images/add.png',
                  width: 10,
                  height: 10,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 3,),
                          
                        Text(description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kGrey,
                          fontSize: 12,
                        ),)
                      ],
                    ),
                  ),
                        
                  SizedBox(
                    width: 125,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("-\$$amount",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 3,),
                            
                          Text("oct 10",
                          style: TextStyle(
                            color: kGrey,
                            fontSize: 12
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
