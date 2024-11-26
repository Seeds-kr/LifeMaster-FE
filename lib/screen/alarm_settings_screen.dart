import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifemaster_proj2/screen/alarm_add_screen.dart';

class AlarmSettingsScreen extends StatefulWidget {
  final DateTime initialAlarmTime;

  AlarmSettingsScreen({required this.initialAlarmTime});

  @override
  _AlarmSettingsScreenState createState() => _AlarmSettingsScreenState();
}

class _AlarmSettingsScreenState extends State<AlarmSettingsScreen> {
  late DateTime _alarmTime;
  List<Map<String, dynamic>> _alarms = [];

  final List<String> _dayOrder = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  void initState() {
    super.initState();
    _alarmTime = widget.initialAlarmTime;
  }

  void _navigateToAddAlarm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlarmAddScreen()),
    );

    if (result != null) {
      result['days']
          .sort((a, b) => _dayOrder.indexOf(a).compareTo(_dayOrder.indexOf(b)));

      setState(() {
        _alarms.add(result);
      });
    }
  }

  void _deleteAlarm(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("알람 삭제"),
          content: Text("알람을 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _alarms.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알람 설정"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddAlarm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "알람",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _alarms.length,
                itemBuilder: (context, index) {
                  final alarm = _alarms[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('a hh:mm').format(alarm['time']),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                alarm['name'] ?? "알람 ${index + 1}",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: alarm['days']
                                    .map<Widget>((day) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Text(
                                            day,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteAlarm(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
