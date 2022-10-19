import 'dart:ui';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/addnote.dart';
import 'package:noteapp/screens/notetabs/favoritenotes.dart';
import 'package:noteapp/screens/notetabs/highlights.dart';
import 'package:noteapp/screens/notetabs/notespage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/classnotlar.dart';
import '../neededthings/neededthings.dart';
import '../neededthings/notesneededthings.dart';
import '../util/databasehelper.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectedindex = 0;

class _HomePageState extends State<HomePage> {

  List<Not>? tumnotlar;
  Databasehelper databasehelper = Databasehelper();

  @override
  void initState() {
    super.initState();
    databasehelper = Databasehelper();
    tumnotlar = <Not>[];
  }
  
  @override



  Widget build(BuildContext context) {

    return FutureBuilder(
      future: databasehelper.notlistesigetir(),
      builder: (context, AsyncSnapshot<List<Not>> snapshot){          if (snapshot.connectionState == ConnectionState.done) {
            
            tumnotlar = snapshot.data;
  
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: floatingbutton(context),
          body: allbody(tumnotlar),
        ),
      ),
            );
          } else {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  ]),
            );
          }},

    );
  }

    FloatingActionButton floatingbutton(context) {
    return FloatingActionButton(
      onPressed: () {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Addnot())).then((_) => setState(() {}));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.black,
    );
  }
  
}

