import 'package:flutter/material.dart';

class SleepWidget extends StatelessWidget {
  final String sleepData;
  final Function(String) onUpdate;

  SleepWidget({required this.sleepData, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("수면",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(sleepData, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
