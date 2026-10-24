import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';


import 'package:expenz/page/Add_page/add_page.dart';

import 'package:expenz/services/user_service.dart';
import 'package:expenz/widget_card/income_expenses_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //store the user name
  String username = "";

  @override
  @override
  void initState() {
    super.initState();
    // Call the custom loadUserData function here
    loadUserData();
  }

  // 🟢 Safe method to load user data
  Future<void> loadUserData() async {
    try {
      Map<String, dynamic>? value = await UserService.getUserData();

      if (value != null && mounted) {
        setState(() {
          // Use '??' to catch whether the key is "username" or "userName"
          username = value["username"] ?? value["userName"] ?? "Guest";
        });
        print("User Name Loaded: $username");
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            child: Text(
                              "Wellcome $username",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      //Income and Expend card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpensesCard(
                            title: 'Income',
                            value: '5000',
                            imageUrl: "assets/images/income.png",
                            color: kGreen,
                           
                          ),

                          IncomeExpensesCard(
                            title: 'Expenses',
                            value: '1200',
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
          ],
        ),
      ),
    );
  }
}
