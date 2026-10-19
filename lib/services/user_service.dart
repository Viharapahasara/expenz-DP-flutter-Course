import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
 
 static Future<void> userData(
   String userName,
   String email,
    String password, 
    String confirmPassword,
    BuildContext context,
    bool userReq,
    VoidCallback goToHomePage,) 
    
    async{

  //check password and confirm password
  if(password != confirmPassword){
    //show the mg to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password and confirm Password do not match"))
    );
  }else if(userReq){

  try{
    //create shared 
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString("userName", userName);
    await pref.setString("email", email);
    await pref.setString("password", password);

//show the succsece
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text("User Details Stored Successfully!"))
);
  }
  catch (err){
    err.toString();
  }

  goToHomePage();
 }else{
  goToHomePage();
 }
 }
}