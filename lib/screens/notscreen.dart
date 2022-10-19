import 'package:flutter/material.dart';
import 'package:noteapp/neededthings/addnot_textinput.dart';
import 'package:noteapp/neededthings/addnote_appbar.dart';
import 'package:noteapp/neededthings/neededthings.dart';
import 'package:noteapp/util/databasehelper.dart';

import '../models/classnotlar.dart';
import '../neededthings/pickdate.dart';

Databasehelper databasehelper = Databasehelper();

class NotScrenn extends StatefulWidget {
  NotScrenn(this.index, this.color, this.not);
  Not not;
  int index;
  Color color;

  @override
  State<NotScrenn> createState() => _NotScrennState(index, color, not);
}

class _NotScrennState extends State<NotScrenn> with WidgetsBindingObserver {
  _NotScrennState(this.index, this.color, this.not);
  Color color;
  int index;
  Not not;

  @override
  void initState() {
    super.initState();
    print("Gelen index :$index");

    int deneme = index;
    Color renk = color;

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Databasehelper databasehelper = Databasehelper();
    @override
    void initState() {
      super.initState();
      databasehelper = Databasehelper();
    }

    final _note = TextEditingController();
    final _header = TextEditingController();

    _header.text = "${not.notBaslik}";
    _note.text = "${not.notIcerik}";

    List<Widget> notepagenotes = [
      Note(_header, _note, Colors.blue, sayac: 0, saveposition: 0),
      Note(_header, _note, Colors.red, sayac:1, saveposition: 1),
      Note(_header, _note, Colors.green, sayac:2, saveposition: 2),
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: addnotebody(notepagenotes),
      ),
    );
  }

  SingleChildScrollView Note(
      TextEditingController _header, TextEditingController _note, Color _color,
      {int? sayac, int? saveposition}) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  controller: _header,
                  cursorHeight: 25.0,
                  decoration: InputDecoration(
                    labelText: "Enter Note",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: color,
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                        color: _color,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                        color: _color,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  cursorHeight: 25.0,
                  controller: _note,
                  maxLines: 15,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Enter Note",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: _color,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: _color,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: _color,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            if(sayac==1)
            date,
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
                              Text("Kaydet"),
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
                          if (_header.text != "" &&
                              _note.text != "" &&
                              sayac!=1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: _color,
                                content: Container(
                                  height: 30,
                                  child: Text("Notunuz Kaydedildi"),
                                ),
                              ),
                            );
                            databasehelper.notguncelle(Not.withId(
                                saveposition,
                                "bruuuh",
                                _header.text,
                                _note.text,
                                not.notID));
                            Navigator.pop(context);
                          } else if(_header.text != "" &&
                              _note.text != "" &&
                              addnotedate.isNotEmpty){
                              databasehelper.notguncelle(Not.withId(
                                saveposition,
                                addnotedate[0],
                                _header.text,
                                _note.text,
                                not.notID));
                                Navigator.pop(context);

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: _color,
                                content: Container(
                                  height: 30,
                                  child: Text(
                                      "Notunuz Kaydedilemedi Lütfen Gerekli Alanları Doldurun"),
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
      ),
    );
  }
}
