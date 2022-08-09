import 'package:flutter/material.dart';
import 'package:hawks/constants/color.dart';

Widget appbar(String text, IconButton iconButton) {
  return AppBar(
    title: Text(
      text,
    ),
    centerTitle: true,
    // leading: IconButton(icon: iconButton, onPressed: () {}),
    backgroundColor: primarycolor,
  );
}