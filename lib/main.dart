import 'package:flutter/material.dart';
import 'screen/user_info_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '회원가입 앱',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserInfoScreen(),
    );
  }
}
