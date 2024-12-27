import 'package:flutter/material.dart';
import 'package:lifemaster_proj2/screen/Diary.dart';

void main() {
  runApp(MaterialApp(
    title: '자아성찰',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const CalendarScreen(),
  ));
}
