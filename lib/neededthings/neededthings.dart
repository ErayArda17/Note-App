import 'package:flutter/material.dart';

import 'addnot_textinput.dart';




List<Widget> pages = [
  inputs(notes, head,
      LabelStyleColor: Colors.cyan,
      FillColor: Colors.white,
      BorderSideColor: Colors.black,
      EnableBorderSideColor: Colors.cyan,
      saveposition: 0,
      sayac: 0),
  inputs(notes, head,
      LabelStyleColor: Colors.red,
      BorderSideColor: Colors.black,
      EnableBorderSideColor: Colors.red,
      saveposition: 1,
      sayac: 1),
  inputs(notes, head,
      LabelStyleColor: Colors.green,
      BorderSideColor: Colors.black,
      EnableBorderSideColor: Colors.green,
      saveposition: 2,
      sayac: 2)
];



