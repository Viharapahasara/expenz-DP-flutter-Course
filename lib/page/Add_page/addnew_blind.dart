import 'package:bounce/bounce.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constents.dart';
import 'package:expenz/data/add_new_page.dart';
import 'package:expenz/modles/expense_catagory_modle.dart';
import 'package:expenz/screen/onboard/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddnewBlind extends StatefulWidget {
  final Color bgColor;
  final List<DropdownMenuItem<Object>> item;

  AddnewBlind({super.key, required this.bgColor, required this.item});

  @override
  State<AddnewBlind> createState() => _AddnewBlindState();
}

class _AddnewBlindState extends State<AddnewBlind> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _AmountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _DescriptionController.dispose();
    _AmountController.dispose();

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
              height: 680,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kdefaultpadding,
                        ),
                        child: DropdownButtonFormField(
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
                          onChanged: (value) {},
                        ),
                      ),

                      //
                      // Title
                      TextField(
                        controller: _titleController,

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        decoration: InputDecoration(
                          hintText: "Ttile",
                          hintStyle: TextStyle(color: kGrey, fontSize: 16),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey, width: 1.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: kMainColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      //Description
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kdefaultpadding,
                        ),
                        child: TextField(
                          controller: _DescriptionController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),

                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(color: kGrey, fontSize: 16),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: kGrey, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: kMainColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Amount
                      TextField(
                        controller: _AmountController,

                        keyboardType: TextInputType.number,

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(color: kGrey, fontSize: 16),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey, width: 1.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: kMainColor,
                              width: 1.5,
                            ),
                          ),
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
                        SizedBox(height: 10,),
                      Divider(),
                         SizedBox(height: 10,),
                      
                      Custombutton(buttonName: "Add", color: widget.bgColor, next: (){})
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
