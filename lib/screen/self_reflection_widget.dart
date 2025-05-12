import 'package:flutter/material.dart';

class SelfReflectionWidget extends StatelessWidget {
  final Map<String, dynamic> reflectionData;
  final Function(Map<String, dynamic>) onUpdate;

  SelfReflectionWidget({required this.reflectionData, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange),
              SizedBox(width: 8),
              Text("자아성찰",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          // 추가 기능에 따라 수정 가능
        ],
      ),
    );
  }
}
