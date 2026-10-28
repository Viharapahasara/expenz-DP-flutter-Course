import 'package:bounce/bounce.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';
import 'package:expenz/data/add_new_page.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/modles/income_modle.dart';
import 'package:expenz/screen/onboard/widget/custom_button/custombutton.dart';
import 'package:expenz/services/expense_sevice.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddnewBlind extends StatefulWidget {
  final Color bgColor;
  final List<DropdownMenuItem<Object>> item;

  final void Function(dynamic) addExpense;
  final int page;

  const AddnewBlind({
    super.key,
    required this.bgColor,
    required this.item,
    required this.addExpense,
    required this.page,
  });

  @override
  State<AddnewBlind> createState() => _AddnewBlindState();
}

class _AddnewBlindState extends State<AddnewBlind> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _AmountController = TextEditingController();
  final TextEditingController _expenseCategory = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Object? _selectedCategory;

  DateTime _selectedDate = DateTime.now();
  DateTime _selectTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _DescriptionController.dispose();
    _AmountController.dispose();
    _expenseCategory.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kdefaultpadding),
              child: Text(
                "How Much?",
                style: TextStyle(
                  color: kWhite.withValues(alpha: 0.64),
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              cursorColor: kWhite,

              style: TextStyle(
                fontSize: 60,
                color: kWhite,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: "0",
                hintStyle: TextStyle(
                  fontSize: 60,
                  color: kWhite,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),

            SizedBox(height: 30),

            Container(
              width: double.infinity,
              height: 740,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(40),
                  left: Radius.circular(40),
                ),
              ),

              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      //catogary selector drop down
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Category dropdown
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: kdefaultpadding,
                              ),
                              child: DropdownButtonFormField<Object>(
                                initialValue: _selectedCategory,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  hintText: "Select Category",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.category,
                                    color: kMainColor,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(15),
                                items: widget.item,
                                validator: (value) => value == null
                                    ? 'Please select a category'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value;
                                  });
                                },
                              ),
                            ),

                            // Title
                            TextFormField(
                              controller: _titleController,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a title';
                                }
                                if (value.trim().length < 3) {
                                  return 'Title must be at least 3 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Title",
                                hintStyle: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                    color: kGrey,
                                    width: 1.2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: kMainColor,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.2,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            // Description
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: kdefaultpadding,
                              ),
                              child: TextFormField(
                                controller: _DescriptionController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Description",
                                  hintStyle: TextStyle(
                                    color: kGrey,
                                    fontSize: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                      color: kGrey,
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: kMainColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Amount
                            TextFormField(
                              controller: _AmountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter an amount';
                                }
                                final amount = double.tryParse(value.trim());
                                if (amount == null) {
                                  return 'Please enter a valid number';
                                }
                                if (amount <= 0) {
                                  return 'Amount must be greater than 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Amount",
                                hintStyle: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                    color: kGrey,
                                    width: 1.2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: kMainColor,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.2,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),

                      //date picker
                      Padding(
                        padding: const EdgeInsets.all(4.0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedDate = value;
                                    });

                                    print(_selectedDate);
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5),

                      //Time picker
                      Padding(
                        padding: const EdgeInsets.all(4.0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectTime = DateTime(
                                        _selectedDate.year,
                                        _selectTime.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: kYellow,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.alarm_outlined,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Text(
                              DateFormat.jm().format(_selectTime),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),

                      Custombutton(
                        buttonName: "Add",
                        color: widget.bgColor,
                        next: () async {
                          // NEW: run all validators, stop here if any field is invalid
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          print("page index : ${widget.page}");
                          //ADD Expense Function
                          if (widget.page == 0) {
                            //save the expense data shared pref
                            List<Expense> loardedExpenses =
                                await ExpenseSevice().loardExpenses();
                            print(loardedExpenses.length);

                            final expense = Expense(
                              id: loardedExpenses.length + 1,
                              title: _titleController.text
                                  .trim(), // CHANGED: trim spaces
                              // CHANGED: amount is already validated, so parse directly
                              amount: double.parse(
                                _AmountController.text.trim(),
                              ),
                              category: _selectedCategory as ExpenseCategory,
                              date: _selectedDate,
                              time: _selectTime,
                              description: _DescriptionController.text
                                  .trim(), // CHANGED: trim spaces
                            );

                            widget.addExpense(expense);

                            List<Expense> updatedList = await ExpenseSevice()
                                .loardExpenses();
                            print(
                              "📊 Current Total Expenses in Storage: ${updatedList.length}",
                            );

                            _titleController.clear();
                            _AmountController.clear();
                            _DescriptionController.clear();

                            //ADD Income Function
                          } else if (widget.page == 1) {
                            // save the income data share pref
                            List<Income> loadedIncome = await IncomeService()
                                .loardIncome();
                            print(loadedIncome.length);

                            final income = Income(
                              id: loadedIncome.length + 1,
                              title: _titleController.text
                                  .trim(), // CHANGED: trim spaces
                              // CHANGED: amount is already validated, so parse directly
                              amount: double.parse(
                                _AmountController.text.trim(),
                              ),
                              catagory: _selectedCategory as IncomeCategory,
                              date: _selectedDate,
                              time: _selectTime,
                              description: _DescriptionController.text
                                  .trim(), // CHANGED: trim spaces
                            );

                            widget.addExpense(income);

                            List<Income> updateIncomeList =
                                await IncomeService().loardIncome();
                            print(
                              "📊 Current Total Income in Storage: ${updateIncomeList.length}",
                            );

                            _titleController.clear();
                            _AmountController.clear();
                            _DescriptionController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
