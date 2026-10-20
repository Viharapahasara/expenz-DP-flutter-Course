import 'package:expenz/constants/colors.dart';
import 'package:expenz/page/add_page.dart';
import 'package:expenz/page/budget_page.dart';
import 'package:expenz/page/home_page.dart';
import 'package:expenz/page/profile_page.dart';
import 'package:expenz/page/transcripton_page.dart';
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

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", kMainColor, labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.list_rounded, "Records", kMainColor, labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.add, "Add", kMainColor, labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.rocket, "Budget", kMainColor, labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.person, "Profile", kMainColor, labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
    
    
  ]);

  @override
  void initState() {
    super.initState();
    // Controller එක initialize කරනවා
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  void dispose() {
    _navigationController.dispose(); // Memory leak නොවෙන්න dispose කරනවා
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBody(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

 
  Widget _buildBody() {
    switch (selectedPos) {
      case 0:
        return const HomePage();
      case 1:
        return const TransactionPage();
      case 2:
        return const AddPage();
      case 3:
        return const BudgetPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
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