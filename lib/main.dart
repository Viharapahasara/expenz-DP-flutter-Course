import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
      ),

      home: Scaffold(
        body: Center(
          child: Text("hello Flutter",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight(800)
          ),),
        ),
      ),
    );
  }
}