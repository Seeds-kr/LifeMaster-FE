import 'package:flutter/material.dart';
import 'package:lifemaster_proj3/screen/alarm_list_screen.dart';

class AlarmWidget extends StatelessWidget {
  final DateTime initialAlarmTime;
  final Function(TimeOfDay) onAlarmSet;

  AlarmWidget({required this.initialAlarmTime, required this.onAlarmSet});

  @override
  Widget build(BuildContext context) {
    final hour = initialAlarmTime.hour > 12
        ? initialAlarmTime.hour - 12
        : initialAlarmTime.hour == 0
            ? 12
            : initialAlarmTime.hour;
    final period = initialAlarmTime.hour >= 12 ? '오후' : '오전';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.alarm, color: Colors.brown),
              SizedBox(width: 8),
              Text(
                "알람",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${initialAlarmTime.month}월 ${initialAlarmTime.day}일  $period $hour:${initialAlarmTime.minute.toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("설정", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // 알람 설정 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlarmListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
