import 'package:expenz/constants/colors.dart';
import 'package:expenz/page/main_screen.dart';

import 'package:expenz/screen/onboard/widget/custom_button/custombutton.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

class UserdataScreen extends StatefulWidget {
  const UserdataScreen({super.key});

  @override
  State<UserdataScreen> createState() => _UserdataScreenState();
}

class _UserdataScreenState extends State<UserdataScreen> {
  //For the check box
  bool _rememberME = false;

  //Form key for the validations
  final _formKey = GlobalKey<FormState>();

  //controller for the text from feilds
  final TextEditingController _UserNameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _ConformPasswordController =
      TextEditingController();

  /// Validates password strength.
  /// Returns an error message if the password is weak, or null if strong.
  String? _validatePasswordStrength(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  void dispose() {
    _UserNameController.dispose();
    _EmailController.dispose();
    _PasswordController.dispose();
    _ConformPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your \nPersonal Details",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight(800)),
              ),

              SizedBox(height: 50),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //get name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _UserNameController,
                        validator: (value) {
                          //check weather the user entered a valid user name
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),

                    //get email
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _EmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Email";
                          }
                          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(value.trim())) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),

                    //get pasword
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _PasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter a Password";
                          }
                          return _validatePasswordStrength(value);
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _ConformPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Confirm Your Password";
                          }
                          if (value != _PasswordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    //remember for the next time

                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            activeColor: kMainColor,

                            value: _rememberME,
                            title: Text(
                              "Remember Me for the next time",
                              style: TextStyle(color: kGrey, fontSize: 15),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if(_rememberME){
                                  _rememberME = false;
                                }else{
                                  _rememberME = true;
                                }
                                   

                                    print(_rememberME);
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 60),

                    Custombutton(
                      buttonName: "Next",
                      color: kMainColor,
                      next: () async {
                        print("hello");
                        if (_formKey.currentState!.validate()) {
                          //Form is valuid prossec data
                          String userName = _UserNameController.text;
                          String email = _EmailController.text;
                          String password = _PasswordController.text;
                          String comPassword = _ConformPasswordController.text;

                          //save ther user data in storage

                          await UserService.userData(
                            userName,
                            email,
                            password,
                            comPassword,
                            context,
                            _rememberME,
                            () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            },
                          );

                          print(userName);  
                          print(email);
                          print(password);
                          print(comPassword);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
