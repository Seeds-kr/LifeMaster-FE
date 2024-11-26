import 'package:flutter/material.dart';
import 'package:lifemaster_proj2/screen/alarm_settings_screen.dart';

class AlarmWidget extends StatefulWidget {
  final DateTime initialAlarmTime;
  final Function(TimeOfDay) onAlarmSet;

  AlarmWidget({required this.initialAlarmTime, required this.onAlarmSet});

  @override
  _AlarmWidgetState createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  late DateTime _alarmTime;

  @override
  void initState() {
    super.initState();
    _alarmTime = widget.initialAlarmTime;
  }

  void _openAlarmSettings() async {
    final updatedTime = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlarmSettingsScreen(initialAlarmTime: _alarmTime),
      ),
    );

    if (updatedTime != null) {
      setState(() {
        _alarmTime = updatedTime;
      });
      widget.onAlarmSet(TimeOfDay.fromDateTime(_alarmTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hour = _alarmTime.hour > 12
        ? _alarmTime.hour - 12
        : _alarmTime.hour == 0
            ? 12
            : _alarmTime.hour;
    final period = _alarmTime.hour >= 12 ? '오후' : '오전';

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
                "${_alarmTime.month}월 ${_alarmTime.day}일  $period $hour:${_alarmTime.minute.toString().padLeft(2, '0')}",
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
                onPressed: _openAlarmSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
