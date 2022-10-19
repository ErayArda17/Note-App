import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/models/classnotlar.dart';

import '../screens/notdetay.dart';
import '../screens/notetabs/favoritenotes.dart';
import '../screens/notetabs/highlights.dart';
import '../screens/notetabs/notespage.dart';
import '../util/databasehelper.dart';

NestedScrollView allbody(tumnotlar) {
  return NestedScrollView(
    floatHeaderSlivers: true,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            leading: Image.asset(
              "assets/icons/note.png",
              fit: BoxFit.fill,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            floating: true,
            snap: true,
            expandedHeight: 110.0,
            title: Text(
              "Note App",
              style: GoogleFonts.lato(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: MySearchDelegate(tumnotlar));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              )
            ],
            bottom: tabbar(),
          ),
        )
      ];
    },
    body: TabBarView(children: [Home(), highlights(), favoritenotes()]),
  );
}

PreferredSize tabbar() {
  return PreferredSize(
    preferredSize: Size(15, 15),
    child: TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Text(
              "Notes",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Tab(
            child: Text(
              "Special Days",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Tab(
            child: Text(
              "Favorite Notes",
              style: TextStyle(color: Colors.green),
            ),
          )
        ]),
  );
}

class MySearchDelegate extends SearchDelegate {
  List<Not> tumnotlar;

  MySearchDelegate(
    this.tumnotlar,
  ) {
    print(tumnotlar);
  }
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    query;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
  }

  @override
  Widget buildResults(BuildContext context) {
    var filtredlistbaslik = tumnotlar
        .where((element) =>
            element.notBaslik!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    var filtredlistnot = tumnotlar
        .where((element) =>
            element.notIcerik!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // TODO: implement buildResults  }
    return filtredlistbaslik.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              var gosterilecekeleman = filtredlistbaslik[index];

              return filtredlistbaslik[index].kategoriId == 2
                  ? Notlar(index, Colors.green, filtredlistbaslik,
                      filtredlistbaslik[index], 0)
                  : filtredlistbaslik[index].kategoriId == 1
                      ? Notlar(index, Colors.red, filtredlistbaslik,
                          filtredlistbaslik[index], 1)
                      : Notlar(index, Colors.blue, filtredlistbaslik,
                          filtredlistbaslik[index], 2);
            },
            itemCount: filtredlistbaslik.length,
          )
        : filtredlistnot.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var gosterilecekeleman = filtredlistnot[index];

                  return filtredlistnot[index].kategoriId == 2
                      ? Notlar(index, Colors.green, filtredlistnot,
                          filtredlistnot[index], 0)
                      : filtredlistnot[index].kategoriId == 1
                          ? Notlar(index, Colors.red, filtredlistnot,
                              filtredlistnot[index], 1)
                          : Notlar(index, Colors.blue, filtredlistnot,
                              filtredlistnot[index], 2);
                },
                itemCount: filtredlistnot.length,
              )
            : Center(
                child: Text("We don't have something like this"),
              );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}

Builder Notlar(i, Color color, tumnotlar, Not not, int kategoriid) {
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
                        NotDetay(color, not, i, tumnotlar, 1)));
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
                      if (kategoriid == 1)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Date:${tumnotlar![i].lastday}",
                            style: GoogleFonts.actor(fontSize: 13),
                          ),
                        ),
                    ]),
              )),
        ),
      );
    });
  } else {
    return Builder(builder: (context) => Text("Bruuh"));
  }
}
