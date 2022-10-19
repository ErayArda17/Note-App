
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/models/classnotlar.dart';

import 'package:noteapp/neededthings/neededthings.dart';
import 'package:noteapp/util/databasehelper.dart';
import '../screens/notetabs/notespage.dart';
import 'pickdate.dart';

Databasehelper databasehelper = Databasehelper();

var date = HomePage();
final head = TextEditingController();
final notes = TextEditingController();
SingleChildScrollView inputs(
    TextEditingController addnot, TextEditingController addhead,
    {Color LabelStyleColor = Colors.black,
    Color FillColor = Colors.white,
    Color BorderSideColor = Colors.white,
    Color EnableBorderSideColor = Colors.white,
    int sayac = 0,
    int? saveposition}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
              controller: head,
              autocorrect:true,
              cursorHeight: 25.0,
              decoration: InputDecoration(
                labelText: "Enter Header",
                labelStyle: TextStyle(color: LabelStyleColor),
                fillColor: FillColor,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: BorderSideColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(
                    color: EnableBorderSideColor,
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              cursorHeight: 25.0,
              controller: notes,
              maxLines: 15,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: "Enter Note",
                labelStyle: TextStyle(color: LabelStyleColor),
                fillColor: FillColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: BorderSideColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: EnableBorderSideColor,
                    width: 2.0,
                  ),
                ),
              )),
        ),
        if (sayac == 1) date,
        SizedBox(
          height: 55,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Builder(builder: (context) {
            return Stack(
              children: [
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 3),
                          Text("Save"),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.yellow]),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onTap: () {
                    {
                      if (head.text != "" && notes.text != "" && sayac != 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: EnableBorderSideColor,
                            content: Container(
                              height: 30,
                              child: Text("Notunuz Kaydedildi"),
                            ),
                          ),
                        );
                          databasehelper.notekle(Not(saveposition, "bruh",
                              "${head.text}", "${notes.text}"));
                        Navigator.pop(context);
                        head.clear();
                        notes.clear();



                      } else if (head.text != "" &&
                          notes.text != "" &&
                          addnotedate.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: EnableBorderSideColor,
                            content: Container(
                              height: 30,
                              child: Text("Notunuz Kaydedildi"),
                            ),
                          ),
                        );
                        databasehelper.notekle(Not(
                            saveposition,
                            "${addnotedate[0]}",
                            "${head.text}",
                            "${notes.text}"));
                       Navigator.pop(context);
                        head.clear();
                        notes.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: EnableBorderSideColor,
                            content: Container(
                              height: 30,
                              child: Text(
                                  "Your Note Could Not Be Saved Please Fill In The Required Fields"),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ],
    ),
  );
}
