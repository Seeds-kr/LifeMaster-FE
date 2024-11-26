import 'package:flutter/material.dart';

class DetoxWidget extends StatefulWidget {
  final Map<String, dynamic> detoxData;
  final Function(Map<String, dynamic>) onUpdate;

  DetoxWidget({required this.detoxData, required this.onUpdate});

  @override
  _DetoxWidgetState createState() => _DetoxWidgetState();
}

class _DetoxWidgetState extends State<DetoxWidget> {
  List<Map<String, String>> allowedApps = [
    {"name": "Instagram"},
    {"name": "X"},
  ];

  List<Map<String, String>> timeLocks = [
    {"day": "매주 월요일", "time": "01:00PM ~ 04:00PM"},
    {"day": "매주 화요일", "time": "01:00PM ~ 04:00PM"},
  ];

  void _addTimeLock() {
    setState(() {
      timeLocks.add({"day": "매주 수요일", "time": "02:00PM ~ 05:00PM"});
    });
  }

  void _removeTimeLock(int index) {
    setState(() {
      timeLocks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "디톡스",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "오늘 누적 시간",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            "06:01:00",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "허용할 서비스",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: allowedApps.map((app) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(app["name"]!),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "시간 잠금 설정",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _addTimeLock,
                child: Text("추가"),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...timeLocks.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> lock = entry.value;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("${lock['day']}"),
              subtitle: Text("${lock['time']}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeTimeLock(index),
              ),
            );
          }).toList(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text("시작하기"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
