

import 'dart:convert';

import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  static const String _incomeKey = 'income';

  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      

      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingIncome = pref.getStringList(_incomeKey);

      //convert the exsixting income data to  a list of object
      List<Income> exsistingIncomeObject = [];

      if(exsistingIncome != null){
        exsistingIncomeObject = exsistingIncome.map((e) => Income.fromJSON(json.decode(e))).toList();
      }

      //add new Incomes to the list
      exsistingIncomeObject.add(income);

    //convert the exsisting object to the JSON list of String
    List<String> updateIncomes = exsistingIncomeObject.map((e) => json.encode(e.toJSON())).toList();
                                                      
    await pref.setStringList(_incomeKey, updateIncomes);
    print("Successefully saved to Storage! Items count : ${updateIncomes.length}");

    //show successe mg
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Income added Successfully!"),
        duration: Duration(seconds: 2),)
      );
    }

    } catch (error) {
      print("Error mg of the saveIncome: ${error.toString()}");
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

  Future<List<Income>> loardIncome() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingIncome = pref.getStringList(_incomeKey);

      //convert to exsisting income to a list on object
      List<Income> loadedIncome = [];

      if (exsistingIncome != null) {
        loadedIncome = exsistingIncome
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      return loadedIncome;
    } catch (error) {
      print("Error inside loardIncome : ${error.toString()}");
      return [];
    }
  }

  //delete an income
  Future<void> deleteIncome(int id, BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncome = pref.getStringList(_incomeKey);

      List<Income> incomeList = existingIncome == null
          ? []
          : existingIncome
              .map((e) => Income.fromJSON(json.decode(e)))
              .toList();

      incomeList.removeWhere((item) => item.id == id);

      await pref.setStringList(
        _incomeKey,
        incomeList.map((e) => json.encode(e.toJSON())).toList(),
      );

      if (messenger != null && messenger.mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text("Income deleted successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }

    } catch (error) {
      print("Error inside deleteIncome : ${error.toString()}");
      if (messenger != null && messenger.mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text("Error on deleting Income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}