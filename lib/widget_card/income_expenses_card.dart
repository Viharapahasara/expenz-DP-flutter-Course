import 'package:bounce/bounce.dart';
import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';

class IncomeExpensesCard extends StatefulWidget {
  final String title;
  final String value;
  final String imageUrl;
  final Color color;
  //final VoidCallback navigate;

  const IncomeExpensesCard({
    super.key,
    required this.title,
    required this.value,
    required this.color, required this.imageUrl, 
    //required this.navigate,
  });

  @override
  State<IncomeExpensesCard> createState() => _IncomeExpensesCardState();
}

class _IncomeExpensesCardState extends State<IncomeExpensesCard> {
  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: () {
          //  widget.navigate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 95,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  width: 30,),
                ),
              

              SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "\$${widget.value}",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
