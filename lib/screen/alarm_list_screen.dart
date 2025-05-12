import 'package:flutter/material.dart';

import 'alarm_add_screen.dart';

class AlarmListScreen extends StatefulWidget {
  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  List<Map<String, dynamic>> alarms = [
    {
      "name": "지금 일어나면 지각",
      "time": "07:10 AM",
      "days": ["월", "화", "목", "금", "토"],
      "snooze": true,
      "preventSleep": false,
      "sound": "세상에서 제일 듣기 싫은 알람.mp4",
      "missions": ["간단한 수학 문제 풀기", "따라 누르기", "글 따라쓰기"]
    },
    {
      "name": "알람 2",
      "time": "06:30 AM",
      "days": ["화", "수", "금"],
      "snooze": false,
      "preventSleep": true,
      "sound": "알람2.mp4",
      "missions": ["간단한 수학 문제 풀기"]
    },
  ];

  IconData _getMissionIcon(String mission) {
    switch (mission) {
      case "간단한 수학 문제 풀기":
        return Icons.calculate;
      case "따라 누르기":
        return Icons.touch_app;
      case "글 따라쓰기":
        return Icons.edit;
      default:
        return Icons.help_outline;
    }
  }

  void _navigateToAddAlarmScreen() async {
    final newAlarm = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlarmAddScreen(),
      ),
    );

    if (newAlarm != null) {
      setState(() {
        alarms.add(newAlarm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알람"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _navigateToAddAlarmScreen,
            child: Text(
              "추가",
              style: TextStyle(color: Colors.brown, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 알람 이름과 스위치
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      alarm["time"],
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700,
                      ),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          // 알람 활성화/비활성화 처리
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  alarm["name"],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 12),
                // 반복 요일
                Row(
                  children: alarm["days"]
                      .map<Widget>((day) => Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              day,
                              style: TextStyle(color: Colors.brown.shade800),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 12),
                // 랜덤 미션 아이콘
                Row(
                  children: alarm["missions"].map<Widget>((mission) {
                    final isActive = alarm["missions"].contains(mission);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        _getMissionIcon(mission),
                        size: 28,
                        color: isActive ? Colors.brown : Colors.grey.shade400,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12),
                // 사운드 정보
                Text(
                  "사운드: ${alarm["sound"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
