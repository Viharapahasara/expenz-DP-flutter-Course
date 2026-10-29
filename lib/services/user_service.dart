import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

  //check password and confirm password
  if(password != confirmPassword){
    //show the mg to the user
    messenger.showSnackBar(
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
messenger.showSnackBar(
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
          String? email = pref.getString("email");
          return {"userName" : userName ?? "", "email" : email ?? ""};
      }

      static Future<void> updateProfile({
        required String userName,
        required String email,
      }) async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        await preferences.setString('userName', userName.trim());
        await preferences.setString('email', email.trim());
      }

      static Future<String?> getProfileImagePath() async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        return preferences.getString('profileImagePath');
      }

      static Future<String> saveProfileImage(XFile image) async {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String extension = image.name.contains('.')
            ? image.name.split('.').last.toLowerCase()
            : 'jpg';
        final String destinationPath =
            '${directory.path}/profile_${DateTime.now().millisecondsSinceEpoch}.$extension';
        final File savedImage = await File(image.path).copy(destinationPath);

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final String? previousPath = preferences.getString('profileImagePath');
        await preferences.setString('profileImagePath', savedImage.path);

        if (previousPath != null && previousPath != savedImage.path) {
          final File previousImage = File(previousPath);
          if (await previousImage.exists()) await previousImage.delete();
        }
        return savedImage.path;
      }

      static Future<void> logout() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        final String? imagePath = pref.getString('profileImagePath');
        if (imagePath != null) {
          final File image = File(imagePath);
          if (await image.exists()) await image.delete();
        }
        await pref.remove("userName");
        await pref.remove("email");
        await pref.remove("password");
        await pref.remove('profileImagePath');
      }
}