import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/neededthings/neededthings.dart';
import 'package:noteapp/screens/notscreen.dart';

import '../../models/classnotlar.dart';
import '../../neededthings/addnote_appbar.dart';
import '../../util/databasehelper.dart';

import '../notdetay.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Not>? tumnotlar;
  Databasehelper databasehelper = Databasehelper();

  @override
  void initState() {
    super.initState();
    databasehelper = Databasehelper();
    tumnotlar = <Not>[];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: databasehelper.notlistesigetir(),
        builder: (context, AsyncSnapshot<List<Not>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            tumnotlar = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                  itemCount: tumnotlar!.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      color: Colors.white12,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (tumnotlar![index].kategoriId == 0)
                              Notlar(index, Colors.blue, tumnotlar,
                                  tumnotlar![index]),
                          ],
                        ),
                      ),
                    );
                  })),
            );
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center, children: []);
          }
        });
  }

  Builder Notlar(i, Color color, tumnotlar, Not not) {
    if (tumnotlar.isNotEmpty) {
      return Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotDetay(color, not, i, tumnotlar, 1)))
                  .then((_) => setState(() {}));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: color.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${tumnotlar![i].notBaslik}",
                          style: GoogleFonts.aladin(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tumnotlar![i].notIcerik,
                            style: GoogleFonts.alice(
                                fontSize: 15,
                                color: Colors.black.withOpacity(.4))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("   Edit   "),
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
                                                  NotScrenn(i, color, not)))
                                      .then((_) => setState(() {}));
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(" Delete "),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [Colors.white, Colors.red],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  databasehelper
                                      .notSil(tumnotlar[i].notID)
                                      .then((silinenId) {
                                    if (silinenId != 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: color,
                                          content: Container(
                                              height: 20,
                                              color: color,
                                              child: Text("Note Deleted")),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      setState(() {});
                                    }
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        );
      });
    } else {
      return Builder(builder: (context) => Text("Bruuh"));
    }
  }
}
