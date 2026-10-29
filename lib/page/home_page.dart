import 'package:chartify/chartify.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';


import 'package:expenz/services/expense_sevice.dart';
import 'package:expenz/services/income_service.dart';

import 'package:expenz/services/user_service.dart';
import 'package:expenz/widget_card/expense_card.dart';
import 'package:expenz/widget_card/income_card.dart';
import 'package:expenz/widget_card/income_expenses_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;

  const HomePage({super.key, required this.expenseList, required this.incomeList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    loadUserData();
    loadTotalIncome();
    loardTotalExpense();
  }

  //  Safe method to load user data
  Future<void> loadUserData() async {
    try {
      Map<String, dynamic>? value = await UserService.getUserData();

      if (mounted) {
        setState(() {
          // Use '??' to catch whether the key is "username" or "userName"
          username = value["username"] ?? value["userName"] ?? "Guest";
        });
        debugPrint("User Name Loaded: $username");
      }
    } catch (e) {
      debugPrint("Error loading user data: $e");
    }
  }

  BarChartData _buildMonthlyChartData() {
    final int currentYear = DateTime.now().year;
    final List<DateTime> months = List<DateTime>.generate(
      12,
      (int index) => DateTime(currentYear, index + 1),
    );
    const List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final List<String> categories = months
        .map((DateTime month) => monthNames[month.month - 1])
        .toList();
    final List<double> monthlyIncome = months.map((DateTime month) {
      return widget.incomeList
          .where(
            (Income income) =>
                income.date.year == month.year &&
                income.date.month == month.month,
          )
          .fold<double>(0, (double total, Income income) => total + income.amount);
    }).toList();
    final List<double> monthlyExpenses = months.map((DateTime month) {
      return widget.expenseList
          .where(
            (Expense expense) =>
                expense.date.year == month.year &&
                expense.date.month == month.month,
          )
          .fold<double>(
            0,
            (double total, Expense expense) => total + expense.amount,
          );
    }).toList();

    return BarChartData(
      series: [
        BarSeries.fromValues<double>(
          name: 'Income',
          values: monthlyIncome,
          color: kGreen,
        ),
        BarSeries.fromValues<double>(
          name: 'Expenses',
          values: monthlyExpenses,
          color: kRed,
        ),
      ],
      xAxis: BarXAxisConfig(categories: categories),
      yAxis: const BarYAxisConfig(min: 0),
      grouping: BarGrouping.grouped,
      direction: BarDirection.vertical,
    );
  }

  @override
  Widget build(BuildContext context) {

  //to Expense List
   final List<Expense> lastFive =widget.expenseList.reversed.take(3).toList();
    
    //to income List
    final List<Income> lastFiveI =widget.incomeList.reversed.take(3).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: kMainColor.withValues(alpha: 0.37),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(kdefaultpadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kMainColor, width: 2.0),
                            ),

                            child: Icon(Icons.person, size: 30),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wellcome,",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          username,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: kWhite,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(width: 10),

                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.notifications,
                                    size: 35,
                                    color: kMainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      //Income and Expend card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpensesCard(
                            title: 'Income',
                            value: totalIncome.toStringAsFixed(0),
                            imageUrl: "assets/images/income.png",
                            color: kGreen,
                          ),

                          IncomeExpensesCard(
                            title: 'Expenses',
                            value: totalExpense.toStringAsFixed(0),
                            imageUrl: "assets/images/expense.png",
                            color: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //profile image , Name  and notification icon
              ],
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Spend Frequency",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "your life frequency",
                style: TextStyle(
                  color: kGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10,),

            // Bar chart
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 500,
                  height: 360,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kWhite,
                     boxShadow: [
                      
                BoxShadow(
                  color: kGrey.withValues(alpha: 0.2),
                  offset: const Offset(0,4),
                  spreadRadius: 2,
                  blurRadius: 8,
                      
                )]
                  ),
                  child: BarChart(
                    data: _buildMonthlyChartData(),
                    tooltip: const TooltipConfig(enabled: true),
                    animation: const ChartAnimation(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Recent Transaction",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 5),

             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Expense",
                style: TextStyle(
                  color: kGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
              
                child:widget.expenseList.isEmpty
                  ? const Center(child: Text("No expense yet"))
                  : ListView.builder(
                  //reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lastFive.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Expense expense = lastFive[index];
              
                    return ExpenseCard(
                      category: expense.category,
                      title: expense.title,
                      description: expense.description,
                      amount: expense.amount.toInt(),
                      date: expense.date,
                    );
                  },
                ),
              ),
            ),

            
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Income",
                style: TextStyle(
                  color: kGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5),
             child: SizedBox(
                width: double.infinity,
               // height: 400,
                child: widget.incomeList.isEmpty
                  ? const Center(child: Text("No income yet"))
                  : ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lastFiveI.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Income income = lastFiveI[index];
                
                      return IncomeCard(
                        category: income.catagory,
                        title: income.title,
                        description: income.description,
                        amount: income.amount.toInt(),
                        date: income.date,
                      );
                    },
                  ),
              ),
           ),

            SizedBox(height: MediaQuery.of(context).padding.bottom * 6),
          ],
        ),
      ),
    );
  }
}
