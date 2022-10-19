import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/util/databasehelper.dart';

import '../models/classnotlar.dart';
import 'notscreen.dart';

class NotDetay extends StatefulWidget {
  NotDetay(this.color, this.not, this.index, this.tumnotlar, this.gelendeger);

  int index;
  Color color;
  Not not;
  dynamic tumnotlar;
  int gelendeger;

  @override
  State<NotDetay> createState() =>
      _NotDetayState(index, color, not, tumnotlar, gelendeger);
}

const snackbar = SnackBar(
  content: Text("Not Silindi"),
  duration: Duration(seconds: 2),
);

class _NotDetayState extends State<NotDetay> {
  _NotDetayState(
      this.index, this.color, this.not, this.tumnotlar, this.gelendeger);
  Color color;
  int index;
  Not not;
  dynamic tumnotlar;
  int gelendeger;
  @override
  Databasehelper databaseHelper = Databasehelper();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Not Detay Ekranı"),
        backgroundColor: color.withOpacity(.4),
        elevation: 1,
      ),
      body: Scaffold(
        backgroundColor: color.withOpacity(.2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "${not.notBaslik}",
                        style: GoogleFonts.aladin(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("${not.notIcerik}",
                          style: GoogleFonts.alice(
                              fontSize: 20,
                              color: Colors.black.withOpacity(1))),
                    ),
                    if (gelendeger == 0)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${not.lastday}",
                          style: GoogleFonts.acme(fontSize: 15),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Edit"),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [Colors.yellow, color],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NotScrenn(index, color, not)),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("    Delete    "),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.red],
                              ),
                            ),
                          ),
                          onTap: () {
                            databaseHelper
                                .notSil(tumnotlar[index].notID)
                                .then((silinenId) {
                              if (silinenId != 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);

                                Navigator.pop(context);
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
