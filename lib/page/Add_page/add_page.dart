import 'package:bounce/bounce.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/page/Add_page/addnew_blind.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final int currentPageNo;
  const AddPage({super.key, required this.currentPageNo});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int currentPage = 0;
  
  
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    
    _pageController = PageController(initialPage: widget.currentPageNo);
    
    
    currentPage = widget.currentPageNo; 
  }

  @override
  void dispose() {
    _pageController.dispose(); // Memory leaks dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("restarted");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentPage = index;
              });
            },

            children: [
              AddnewBlind(
                bgColor: kRed,
                item: ExpenseCategory.values.map((catagory) {
                          return DropdownMenuItem(
                            value: catagory,
                            child: Text(catagory.name),
                          );
                        }).toList(),
              ),
              AddnewBlind(
                bgColor: kGreen,
                item: IncomeCategory.values.map((catagory){
                          return DropdownMenuItem(
                            value: catagory,
                            child: Text(catagory.name),
                          );
                }).toList(),
                ),
            ],
          ),

          //Income and Exchange button
          Positioned(
            top: MediaQuery.of(context).padding.top * 2,
            left: 30,
            right: 30,

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
                              //  currentPage = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.07,
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
                              //  currentPage = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.07,
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
