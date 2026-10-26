import 'package:expenz/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

import 'budgetblind.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Report",
        style: TextStyle(
          color: kBlack,
          fontWeight: FontWeight.w500,
          fontSize: 22
        ),),
        centerTitle:true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top * 2),

           // Text("Financial Report"),

            Budgetblind(),
          ],
        ),
      ),
    );
  }
}
