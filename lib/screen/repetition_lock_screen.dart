import 'package:flutter/material.dart';

class RepetitionLockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "반복잠금",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "반복적으로 특정 시간에 잠금 기능을 설정하세요.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
