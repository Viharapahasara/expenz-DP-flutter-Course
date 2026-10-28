import 'package:expenz/screen/onboard/widget/wrapper.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.checkUserName(),
      builder: (context, snapshot) {
        
        //if the snapshot is stilll awaiting
        if (snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
          
        }else{
          //heare the has usetr name will be set to true of  the data in ther  snapshot  and otherwise false
          bool hasUserName = snapshot.data ?? false;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Inter",
            ),
            home: Wrapper(showMAinScreen: hasUserName),
          );
        }
      },
      );
    }
}