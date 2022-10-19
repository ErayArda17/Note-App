import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/neededthings/addnote_tabbar.dart';

import 'addnot_textinput.dart';

int sayi = 0;
NestedScrollView addnotebody(page) {
  return NestedScrollView(
    floatHeaderSlivers: true,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
                head.clear();
                notes.clear();
                sayi += 1;
              },
            ),
            backgroundColor: Colors.white12,
            elevation: 0,
            expandedHeight: 110.0,
            floating: true,
            snap: true,
            title: Text(
              "Note App",
              style: GoogleFonts.lato(color: Colors.black),
            ),
            bottom: addnotetabbar(),
          ),
        ),
      ];
    },
    body: TabBarView(
      children: [page[0], page[1], page[2]],
    ),
  );
}
