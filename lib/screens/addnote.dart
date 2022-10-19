import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';
import 'package:google_fonts/google_fonts.dart';



import 'package:noteapp/screens/homepage.dart';


import '../neededthings/addnot_textinput.dart';
import '../neededthings/addnote_appbar.dart';
import '../neededthings/addnote_tabbar.dart';
import '../neededthings/neededthings.dart';

class Addnot extends StatefulWidget {
  Addnot({Key? key}) : super(key: key);

  @override
  State<Addnot> createState() => _AddnotState();
}

class _AddnotState extends State<Addnot> {

  void initState() {
    super.initState();
    setState(() {});
  }

  @override

  int kontrolsayi = 0;

  int sayi = 0;
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: addnotebody(pages),
      ),
    );
  }



}
