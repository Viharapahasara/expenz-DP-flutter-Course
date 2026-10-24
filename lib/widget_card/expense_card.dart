import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseCategory category;
  final String title;
  final String description;
  final int amount;
  final DateTime date;

  const ExpenseCard({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    String addDate = DateFormat('MMM d').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        width: double.infinity,
       // height: 100,
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
          ]),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: expenseCategoryColors[category]!.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(expenseCategoryImages[category]!),
                )),
            ),
          
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 12
                        ),)
                      ],),
                    ),
                  ],
                ),
              ) ,
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("-\$$amount",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kRed,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 3,),
                  
                      Text(addDate,
                      style: TextStyle(
                        color: kGrey,
                        fontSize: 12
                      ),)
                    ],
                  ),
                ),
              )         
            ],
          ),
        ),
      ),
    );
  }
}
