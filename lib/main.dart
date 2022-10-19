import 'package:flutter/material.dart';
import 'package:noteapp/screens/homepage.dart';
import 'package:noteapp/screens/notscreen.dart';
import 'package:noteapp/util/databasehelper.dart';



void main(List<String> args) {
  runApp(AppScreen()
  );
}

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: HomePage(),);
  }
}
