import 'package:expenz/constants/colors.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/page/Add_page/add_page.dart';
import 'package:expenz/page/budget_page/budget_page.dart';
import 'package:expenz/page/home_page.dart';
import 'package:expenz/page/profile_page.dart';
import 'package:expenz/page/transcripton_page.dart';
import 'package:expenz/services/expense_sevice.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPos = 0;
  late CircularBottomNavigationController _navigationController;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];
  // Function to fetch data
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseSevice().loardExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
      print(expenseList.toString());
    });
  }

  // Function to add a new Expense
  void addNewExpense(Expense newExpense) async {
    await ExpenseSevice().saveExpenses(newExpense, context);

    setState(() {
      expenseList.add(newExpense);
    });
  }

  //Function to frech Income data
  void frechAllIncome() async {
    List<Income> loardIncome = await IncomeService().loardIncome();
    setState(() {
      incomeList = loardIncome;
      print(incomeList);
    });
  }

  //Function to add new Income
  void addNewIncome(Income newIncome) async {
    await IncomeService().saveIncome(newIncome, context);

    setState(() {
      incomeList.add(newIncome);
    });
  }

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home",
      kMainColor,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.list_rounded,
      "Records",
      kMainColor,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.add,
      "Add",
      kMainColor,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.rocket,
      "Budget",
      kMainColor,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.person,
      "Profile",
      kMainColor,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
    fetchAllExpenses();
    frechAllIncome();
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  //Function to remove a expense
  void removeExpense(Expense expense) {
    ExpenseSevice().deleteExpenses(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //Function to remove an income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //  category total expense
  Map<ExpenseCategory, double> calculateExpwnseCat(){
    Map<ExpenseCategory, double> catrgoryETotal = {
        ExpenseCategory.food : 0,
        ExpenseCategory.health : 0,
        ExpenseCategory.shopping : 0,
        ExpenseCategory.subscription : 0,
        ExpenseCategory.transport : 0,
    };

    for (Expense expence in expenseList){
        catrgoryETotal[expence.category] =
          (catrgoryETotal[expence.category] ?? 0) + expence.amount;
    }
    return catrgoryETotal;
  }   

    Map<IncomeCategory, double> calculateIncomeCat(){
    Map<IncomeCategory, double> catrgoryITotal = {
        IncomeCategory.Freelance : 0,
        IncomeCategory.Passive : 0,
        IncomeCategory.Salary : 0,
        IncomeCategory.Sales : 0,
    };

    for (Income income in incomeList){
        catrgoryITotal[income.catagory] =
          (catrgoryITotal[income.catagory] ?? 0) + income.amount;
    }
    return catrgoryITotal;
  }   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBody(),
          Align(alignment: Alignment.bottomCenter, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (selectedPos) {
      case 3:
        return HomePage(
          expenseList: expenseList,
          incomeList: incomeList,
        ); // 🟢 Case 0 = Home
      case 1:
        return TransactionPage(
          expenseList: expenseList,
          onDismissedExpense: removeExpense,
          incomeList: incomeList,
          onDismissedIncome: removeIncome,
        );
      case 2:
        return AddPage(
          currentPageNo: 0,
          addExpense: addNewExpense,
          addIncome: addNewIncome,
        ); // 🟢 Case 2 = Add
      case 0:
        return BudgetPage(
          expenseCatogery: calculateExpwnseCat(),
          incomeCatogery: calculateIncomeCat(),
        );
      case 4:
        return const ProfilePage();
      default:
        return HomePage(expenseList: expenseList, incomeList: incomeList);
    }
  }

  Widget _buildBottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: 80,
      circleSize: 70,
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPosFromItem) {
        setState(() {
          selectedPos = selectedPosFromItem ?? 0;
        });
      },
    );
  }
}
