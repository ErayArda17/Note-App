  import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';

PreferredSize addnotetabbar() {
    return PreferredSize(
      preferredSize: Size(30, 30),
      child: ColorfulTabBar(unselectedLabelColor: Colors.white, tabs: [
        TabItem(
          title: Row(children: [
            Icon(Icons.note_alt_outlined),
            SizedBox(width: 20),
            Text(
              'Note',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.5)),
            )
          ]),
          color: Colors.cyan,
        ),
        TabItem(
          title: Row(children: [
            Icon(Icons.schedule_outlined),
            SizedBox(width: 20),
            Text(
              'Special Day',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.5)),
            )
          ]),
          color: Colors.red,
        ),
        TabItem(
            title: Row(children: [
              Icon(Icons.favorite_outline),
              SizedBox(width: 20),
              Text(
                'Favorite',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.5)),
              )
            ]),
            color: Colors.green)
      ]),
    );
  }