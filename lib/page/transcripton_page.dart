import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/widget_card/expense_card.dart';
import 'package:expenz/widget_card/income_card.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {

  final List<Income> incomeList;
  final List<Expense> expenseList;
  final void Function(Expense) onDismissedExpense;
  const TransactionPage({
    super.key,
    required this.expenseList,
    required this.onDismissedExpense, required this.incomeList,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top * 2),
        
            Text(
              "See your financial report",
              style: TextStyle(
                color: kMainColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height: 20),
        
            Text(
              "Expenses",
              style: TextStyle(
                color: kBlack,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height: 10),
        
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
        
              child: ListView.builder(
                shrinkWrap: true,
             //   physics: NeverScrollableScrollPhysics(),
                itemCount: widget.expenseList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Expense expense = widget.expenseList[index];
                  print("--- ITEM CATEGORY --- : ${expense.category}");
        
                  return Dismissible(
                    key: ValueKey(expense),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      setState(() {
                        widget.onDismissedExpense(expense);
                      });
                    },
                    child: ExpenseCard(
                      category: expense.category,
        
                      title: expense.title,
                      description: expense.description,
                      amount: expense.amount.toInt(),
                      date: expense.date,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
        
            Divider(),
        
            SizedBox(height: 5),
        
            Text(
              "Income",
              style: TextStyle(
                color: kBlack,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        
            SizedBox(height: 10),
        
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
                width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
               // physics: NeverScrollableScrollPhysics(),
                itemCount: widget.incomeList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Income income = widget.incomeList[index];
                  return Dismissible(
                    key: ValueKey(income),
                    direction: DismissDirection.startToEnd,
                    child: IncomeCard(
                      category: income.catagory,
                      title: income.title!,
                      description: income.description,
                      amount: income.amount!.toInt(),
                      date: income.date,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom*3,)
          ],
        ),
      ),
    );
  }
}
