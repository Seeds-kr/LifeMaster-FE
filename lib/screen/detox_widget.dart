import 'package:flutter/material.dart';

class DetoxWidget extends StatelessWidget {
  final Map<String, dynamic> detoxData;
  final Function(Map<String, dynamic>) onUpdate;

  DetoxWidget({required this.detoxData, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.eco, color: Colors.green),
              SizedBox(width: 8),
              Text("디톡스",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("누적 집중 시간",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  Text("8시간 12분", style: TextStyle(fontSize: 16)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("집중 모드"),
                onPressed: () {
                  onUpdate({...detoxData, "focus": "집중 모드 시작"});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
