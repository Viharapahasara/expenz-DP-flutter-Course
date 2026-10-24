import 'package:flutter/material.dart';

enum IncomeCategory {
  Freelance,
  Salary,
  Passive,
  Sales,
  
}

final Map<IncomeCategory, String> incomeCatagoryImages = {
  IncomeCategory.Freelance: "assets/images/freelance.png",
  IncomeCategory.Passive: "assets/images/car.png",
  IncomeCategory.Salary: "assets/images/health.png",
  IncomeCategory.Sales: "assets/images/salary.png",
};

final Map<IncomeCategory, Color> incomeCatagoryColor = {
  IncomeCategory.Freelance: const Color(0xFFE57373),
  IncomeCategory.Passive: const Color(0xFF81C784),
  IncomeCategory.Sales: const Color(0xFF64B5F6),
  IncomeCategory.Salary: const Color(0xFFFFD54F),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory catagory;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.catagory,
    required this.date,
    required this.time,
    required this.description,
  });

  //convert the income object to aJSON object
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': catagory.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create an expence object from a JSON object
factory Income.fromJSON(Map<String, dynamic> json){

  return Income(
  id: json['id'], 
  title: json['title'], 
  amount: json['amount'], 
  catagory: IncomeCategory.values[json['category']], 
  date: DateTime.parse(json['date']), 
  time: DateTime.parse(json['time']), 
  description: json['description']);
}


}
