import 'package:flutter/material.dart';

// 알람 추가 화면
class AlarmAddScreen extends StatefulWidget {
  @override
  _AlarmAddScreenState createState() => _AlarmAddScreenState();
}

class _AlarmAddScreenState extends State<AlarmAddScreen> {
  TextEditingController _alarmNameController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  List<String> _selectedDays = [];
  bool _isSnoozeEnabled = false;
  bool _isPreventSleepEnabled = false;
  List<String> _selectedMissions = [];
  String _selectedSound = "기본 알람 소리";

  void _saveAlarm() {
    Navigator.pop(context, {
      "name": _alarmNameController.text,
      "time": _selectedDateTime,
      "days": _selectedDays,
      "snooze": _isSnoozeEnabled,
      "preventSleep": _isPreventSleepEnabled,
      "missions": _selectedMissions,
      "sound": _selectedSound,
    });
  }

  void _showRandomMissionDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return RandomMissionDialog(selectedMissions: _selectedMissions);
      },
    );

    if (result != null) {
      setState(() {
        _selectedMissions = result["missions"];
      });
    }
  }

  Widget _buildDaySelector(String day) {
    final isSelected = _selectedDays.contains(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? _selectedDays.remove(day) : _selectedDays.add(day);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown.shade200 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알람 추가"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 알람 이름 입력 필드
            TextField(
              controller: _alarmNameController,
              decoration: InputDecoration(
                hintText: "알람 이름",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // 시간 설정 위젯
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 시간 선택
                      GestureDetector(
                        onTap: () async {
                          final selectedHour = await showModalBottomSheet<int>(
                            context: context,
                            builder: (context) => NumberPickerWidget(
                              minValue: 0,
                              maxValue: 23,
                              initialValue: _selectedDateTime.hour,
                              title: "시간 선택",
                            ),
                          );

                          if (selectedHour != null) {
                            setState(() {
                              _selectedDateTime = DateTime(
                                _selectedDateTime.year,
                                _selectedDateTime.month,
                                _selectedDateTime.day,
                                selectedHour,
                                _selectedDateTime.minute,
                              );
                            });
                          }
                        },
                        child: Text(
                          "${_selectedDateTime.hour.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      // 분 선택
                      GestureDetector(
                        onTap: () async {
                          final selectedMinute =
                              await showModalBottomSheet<int>(
                            context: context,
                            builder: (context) => NumberPickerWidget(
                              minValue: 0,
                              maxValue: 59,
                              initialValue: _selectedDateTime.minute,
                              title: "분 선택",
                            ),
                          );

                          if (selectedMinute != null) {
                            setState(() {
                              _selectedDateTime = DateTime(
                                _selectedDateTime.year,
                                _selectedDateTime.month,
                                _selectedDateTime.day,
                                _selectedDateTime.hour,
                                selectedMinute,
                              );
                            });
                          }
                        },
                        child: Text(
                          "${_selectedDateTime.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // 랜덤 미션
            ListTile(
              title: Text("랜덤 미션"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showRandomMissionDialog,
            ),
            SizedBox(height: 16),

            // 요일 선택
            Row(
              children: ["월", "화", "수", "목", "금", "토", "일"]
                  .map((day) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _buildDaySelector(day),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),

            // 미루기 설정
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("미루기"),
                Switch(
                  value: _isSnoozeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isSnoozeEnabled = value;
                    });
                  },
                ),
              ],
            ),

            // 다시 잠들기 방지
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("다시 잠들기 방지"),
                Switch(
                  value: _isPreventSleepEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isPreventSleepEnabled = value;
                    });
                  },
                ),
              ],
            ),

            // 사운드 설정
            ListTile(
              title: Text("사운드"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // 사운드 설정 화면 이동
              },
            ),

            Spacer(),

            // 저장 버튼
            ElevatedButton(
              onPressed: _saveAlarm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade300,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "저장하기",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 랜덤 미션 다이얼로그
class RandomMissionDialog extends StatefulWidget {
  final List<String> selectedMissions;

  RandomMissionDialog({required this.selectedMissions});

  @override
  _RandomMissionDialogState createState() => _RandomMissionDialogState();
}

class _RandomMissionDialogState extends State<RandomMissionDialog> {
  List<String> _missions = ["간단한 수학 문제 풀기", "따라 누르기", "글 따라쓰기"];
  List<String> _selectedMissions = [];
  String? _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _selectedMissions = widget.selectedMissions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("랜덤 미션"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._missions.map((mission) {
            final isSelected = _selectedMissions.contains(mission);
            return ListTile(
              title: Text(mission),
              trailing: Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedMissions.add(mission);
                    } else {
                      _selectedMissions.remove(mission);
                    }
                  });
                },
              ),
            );
          }).toList(),
          if (_selectedMissions.contains("간단한 수학 문제 풀기"))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["상", "중", "하"].map((difficulty) {
                final isSelected = _selectedDifficulty == difficulty;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDifficulty = difficulty;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.brown : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      difficulty,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              "missions": _selectedMissions,
              "difficulty": _selectedDifficulty,
            });
          },
          child: Text("설정하기"),
        ),
      ],
    );
  }
}

// 숫자 선택용 위젯
class NumberPickerWidget extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final String title;

  NumberPickerWidget({
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    int selectedValue = initialValue;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListWheelScrollView(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              selectedValue = minValue + index;
            },
            children: List.generate(
              maxValue - minValue + 1,
              (index) => Center(
                child: Text(
                  "${(minValue + index).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedValue);
          },
          child: Text("선택"),
        ),
      ],
    );
  }
}
