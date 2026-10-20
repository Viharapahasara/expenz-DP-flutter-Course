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

 //methord to check weather the user name is saved in the shared pref
        static Future<bool> checkUserName() async{
            SharedPreferences prefs = await SharedPreferences.getInstance();

            String? userName = prefs.getString('userName');
            return userName != null;
        }

  //get the use name and the email 
      static Future<Map <String , String>> getUserData() async{
          //create an instence for sharipreferences

          SharedPreferences pref = await SharedPreferences.getInstance();

          String? userName = pref.getString("userName");
          String? email = pref.getString("userName");
          return {"userName" : userName!, "email" : email!};
      }
}