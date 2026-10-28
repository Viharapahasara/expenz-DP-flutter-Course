import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/page/budget_page/widget/pregress_bar.dart';
import 'package:expenz/services/expense_sevice.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:chartify/chartify.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class Budgetblind extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCatogery;
  final Map<IncomeCategory, double> incomeCatogery;

  final bool isExpense;
  const Budgetblind({
    super.key,
    required this.expenseCatogery,
    required this.incomeCatogery,
    required this.isExpense,
  });

  @override
  State<Budgetblind> createState() => _BudgetblindState();
}

class _BudgetblindState extends State<Budgetblind> {
  //section data
  List<PieSection> sections() {
    if (widget.isExpense) {
      return [
        PieSection(
          value: widget.expenseCatogery[ExpenseCategory.food] ?? 0.0,
          label: 'Food',
          color: expenseCategoryColors[ExpenseCategory.food],
        ),
        PieSection(
          value: widget.expenseCatogery[ExpenseCategory.health] ?? 0.0,
          label: 'Health',
          color: expenseCategoryColors[ExpenseCategory.health],
        ),
        PieSection(
          value: widget.expenseCatogery[ExpenseCategory.shopping] ?? 0.0,
          label: 'Shopping',
          color: expenseCategoryColors[ExpenseCategory.shopping],
        ),
        PieSection(
          value: widget.expenseCatogery[ExpenseCategory.subscription] ?? 0.0,
          label: 'Subscription',
          color: expenseCategoryColors[ExpenseCategory.subscription],
        ),
        PieSection(
          value: widget.expenseCatogery[ExpenseCategory.transport] ?? 0.0,
          label: 'Transport',
          color: expenseCategoryColors[ExpenseCategory.transport],
        ),
      ];
    } else {
      return [
        PieSection(
          value: widget.incomeCatogery[IncomeCategory.Freelance] ?? 0.0,
          label: 'Transport',
          color: incomeCatagoryColor[IncomeCategory.Freelance],
        ),
        PieSection(
          value: widget.incomeCatogery[IncomeCategory.Passive] ?? 0.0,
          label: 'Passive',
          color: incomeCatagoryColor[IncomeCategory.Passive],
        ),
        PieSection(
          value: widget.incomeCatogery[IncomeCategory.Salary] ?? 0.0,
          label: 'Salary',
          color: incomeCatagoryColor[IncomeCategory.Salary],
        ),
        PieSection(
          value: widget.incomeCatogery[IncomeCategory.Sales] ?? 0.0,
          label: 'Sales',
          color: incomeCatagoryColor[IncomeCategory.Sales],
        ),
      ];
    }
  }

  //store the user name
  String username = "";
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  void loadTotalIncome() async {
    double value = await IncomeService().sumIncome();
    setState(() {
      totalIncome = value;
    });
  }

  void loardTotalExpense() async {
    double value = await ExpenseSevice().sumExpense();
    setState(() {
      totalExpense = value;
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the custom loadUserData function here

    loadTotalIncome();
    loardTotalExpense();
  }

  List<Widget> _budgetProgressBars() {
    if (widget.isExpense) {
      return [
        PregressBar(
          title: 'Food',
          value: widget.expenseCatogery[ExpenseCategory.food] ?? 0.0,
          total: totalExpense,
          color: expenseCategoryColors[ExpenseCategory.food]!,
        ),
        PregressBar(
          title: 'Health',
          value: widget.expenseCatogery[ExpenseCategory.health] ?? 0.0,
          total: totalExpense,
          color: expenseCategoryColors[ExpenseCategory.health]!,
        ),
        PregressBar(
          title: 'Shopping',
          value: widget.expenseCatogery[ExpenseCategory.shopping] ?? 0.0,
          total: totalExpense,
          color: expenseCategoryColors[ExpenseCategory.shopping]!,
        ),
        PregressBar(
          title: 'Subscription',
          value: widget.expenseCatogery[ExpenseCategory.subscription] ?? 0.0,
          total: totalExpense,
          color: expenseCategoryColors[ExpenseCategory.subscription]!,
        ),
        PregressBar(
          title: 'Transport',
          value: widget.expenseCatogery[ExpenseCategory.transport] ?? 0.0,
          total: totalExpense,
          color: expenseCategoryColors[ExpenseCategory.transport]!,
        ),
      ];
    }

    return [
      PregressBar(
        title: 'Freelance',
        value: widget.incomeCatogery[IncomeCategory.Freelance] ?? 0.0,
        total: totalIncome,
        color: incomeCatagoryColor[IncomeCategory.Freelance]!,
      ),
      PregressBar(
        title: 'Passive',
        value: widget.incomeCatogery[IncomeCategory.Passive] ?? 0.0,
        total: totalIncome,
        color: incomeCatagoryColor[IncomeCategory.Passive]!,
      ),
      PregressBar(
        title: 'Salary',
        value: widget.incomeCatogery[IncomeCategory.Salary] ?? 0.0,
        total: totalIncome,
        color: incomeCatagoryColor[IncomeCategory.Salary]!,
      ),
      PregressBar(
        title: 'Sales',
        value: widget.incomeCatogery[IncomeCategory.Sales] ?? 0.0,
        total: totalIncome,
        color: incomeCatagoryColor[IncomeCategory.Sales]!,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kWhite,
        child: Column(
          children: [
            const SizedBox(height: 100),
      
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
                      offset: const Offset(0, 4),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: PieChart(
                    data: PieChartData(
                      sections: sections(),
                      holeRadius: 0.5,
                      segmentGap: 3,
                      cornerRadius: 4,
                      enableShadows: true,
                      showLabels: false,
                      labelPosition: PieLabelPosition.outside,
                      labelConnector: PieLabelConnector.elbow,
                    ),
                    centerWidget: Text(
                      'Total\n${widget.isExpense ? totalExpense.toStringAsFixed(0) : totalIncome.toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                    ),
                    tooltip: const TooltipConfig(enabled: true),
                    animation: const ChartAnimation(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                ),
              ),
            ),
      
            SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: _budgetProgressBars(),
                ),
              ),
            ),

            SizedBox(height: 120,)
            
          ],
        ),
      ),
    );
  }
}
