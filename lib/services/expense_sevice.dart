import 'dart:convert';

import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseSevice {
  // Expense List
  List<Expense> expensesList = [];

  // Define the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

  // Save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsitingExpenses = pref.getStringList(_expenseKey);

      // Convert the existing expenses to a list of objects
      List<Expense> existingExpenseObject = [];

      if (exsitingExpenses != null) {
        existingExpenseObject = exsitingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // Add the new expense to the list
      existingExpenseObject.add(expense);

      // Convert the existing expense objects back to a list of strings
      List<String> updateExpenses = existingExpenseObject
          .map((e) => json.encode(e.toJSON()))
          .toList();

      await pref.setStringList(_expenseKey, updateExpenses);

      print(
        "✅ Successfully Saved to Storage! Items count: ${updateExpenses.length}",
      );

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print("❌ Error inside saveExpenses: ${error.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Load the expenses from shared preferences
  Future<List<Expense>> loardExpenses() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingExpenses = pref.getStringList(_expenseKey);

      // Convert the existing expenses to a list of expense objects
      List<Expense> loardedExpenses = [];
      if (exsistingExpenses != null) {
        loardedExpenses = exsistingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }
      return loardedExpenses;
    } catch (error) {
      print(" Error inside loardExpenses: ${error.toString()}");
      return [];
    }
  }

  //Delete the expense from shared pref
  Future<void> deleteExpenses(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingExpense = pref.getStringList(_expenseKey);

      //convert the exsisting Expense to a list
      List<Expense> exsistingExpenseObject = [];
      if (exsistingExpense != null) {
        exsistingExpenseObject = exsistingExpense
            .map(((e) => Expense.fromJSON(json.decode(e))))
            .toList();
      }

      //remove the expense with the specified id from the list
      exsistingExpenseObject.removeWhere((element) => element.id == id);

      //convert the list of Expense object back to a list of String
      List<String> updateExpense = exsistingExpenseObject
          .map((e) => json.encode(e.toJSON()))
          .toList();

      await pref.setStringList(_expenseKey, updateExpense);

      //show snake bar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense deleted Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
       if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Deleting Expense"),
            duration: Duration(seconds: 2),
          ),
        );
    }}
  }
}
