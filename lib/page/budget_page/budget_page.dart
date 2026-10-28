import 'package:bounce/bounce.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/page/budget_page/budgetblind.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCatogery;
  final Map<IncomeCategory, double> incomeCatogery;
  const BudgetPage({
    super.key,
    required this.expenseCatogery,
    required this.incomeCatogery,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int currentPage = 0;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    currentPage = 0;
  }

  @override
  void dispose() {
    _pageController.dispose(); // Memory leaks dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            color: kBlack,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body:
          // Text("Financial Report"),
          Stack(
            children: [
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                // scrollDirection: Axis.vertical, // Udata pahalata (vertical) swipe karannanam meka danna puluwan
                children: [
                  Budgetblind(
                    expenseCatogery: widget.expenseCatogery,
                    incomeCatogery: widget.incomeCatogery,
                    isExpense: true,
                  ),
                  Budgetblind(
                    expenseCatogery: widget.expenseCatogery,
                    incomeCatogery: widget.incomeCatogery,
                    isExpense: false,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Bounce(
                  child: Visibility(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: currentPage == 0 ? kRed : kGreen,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kWhite.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pageController.jumpToPage(0);
                                  currentPage = 0;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: currentPage == 0
                                      ? kRed
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Expense",
                                    style: TextStyle(
                                      color: currentPage == 0 ? kWhite : kBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pageController.jumpToPage(1);
                                  currentPage = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: currentPage == 1
                                      ? kGreen
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Income",
                                    style: TextStyle(
                                      color: currentPage == 1 ? kWhite : kBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
