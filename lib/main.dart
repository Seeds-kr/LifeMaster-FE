import 'package:flutter/material.dart';
import 'screen/lock_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '잠금 기능',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LockSelectionScreen(), // 별도로 분리한 화면을 호출
    );
  }
}
