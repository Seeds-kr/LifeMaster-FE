import 'package:flutter/material.dart';

class AlarmAddScreen extends StatefulWidget {
  @override
  _AlarmAddScreenState createState() => _AlarmAddScreenState();
}

class _AlarmAddScreenState extends State<AlarmAddScreen> {
  String _alarmName = "";
  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 0);
  List<String> _selectedDays = [];
  bool _snooze = false;
  bool _preventSleep = false;
  String _sound = "세상에서 제일 듣기 싫은 알람.mp4";
  List<String> _randomMissions = [];

  void _selectRandomMission() async {
    final missions = await showDialog<List<String>>(
      context: context,
      builder: (context) =>
          RandomMissionDialog(selectedMissions: _randomMissions),
    );

    if (missions != null) {
      setState(() {
        _randomMissions = missions;
      });
    }
  }

  void _saveAlarm() {
    final newAlarm = {
      "name": _alarmName.isNotEmpty ? _alarmName : "새로운 알람",
      "time": "${_selectedTime.format(context)}",
      "days": _selectedDays,
      "snooze": _snooze,
      "preventSleep": _preventSleep,
      "sound": _sound,
      "missions": _randomMissions,
    };

    Navigator.pop(context, newAlarm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알람 추가"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "알람 이름"),
              onChanged: (value) {
                setState(() {
                  _alarmName = value;
                });
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "시간 설정: ${_selectedTime.format(context)}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: ["월", "화", "수", "목", "금", "토", "일"].map((day) {
                final isSelected = _selectedDays.contains(day);
                return ChoiceChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDays.add(day);
                      } else {
                        _selectedDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text("미루기"),
              value: _snooze,
              onChanged: (value) {
                setState(() {
                  _snooze = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("다시 잠들기 방지"),
              value: _preventSleep,
              onChanged: (value) {
                setState(() {
                  _preventSleep = value;
                });
              },
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text("랜덤 미션"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: _selectRandomMission,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _saveAlarm,
              child: Text("저장하기"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RandomMissionDialog extends StatelessWidget {
  final List<String> selectedMissions;

  RandomMissionDialog({required this.selectedMissions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("랜덤 미션 선택"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text("간단한 수학 문제 풀기"),
            value: selectedMissions.contains("간단한 수학 문제 풀기"),
            onChanged: (selected) {
              if (selected == true) {
                selectedMissions.add("간단한 수학 문제 풀기");
              } else {
                selectedMissions.remove("간단한 수학 문제 풀기");
              }
            },
          ),
          // 추가 미션들 추가 가능
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, selectedMissions),
          child: Text("설정하기"),
        ),
      ],
    );
  }
}
