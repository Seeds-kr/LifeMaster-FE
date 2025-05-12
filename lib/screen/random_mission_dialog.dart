import 'package:flutter/material.dart';

class RandomMissionDialog extends StatefulWidget {
  final List<String> initialMissions;
  final String initialDifficulty;

  RandomMissionDialog({
    required this.initialMissions,
    required this.initialDifficulty,
  });

  @override
  _RandomMissionDialogState createState() => _RandomMissionDialogState();
}

class _RandomMissionDialogState extends State<RandomMissionDialog> {
  late List<String> selectedMissions;
  late String difficulty;

  @override
  void initState() {
    super.initState();
    selectedMissions = widget.initialMissions;
    difficulty = widget.initialDifficulty;
  }

  void _toggleMission(String mission) {
    setState(() {
      if (selectedMissions.contains(mission)) {
        selectedMissions.remove(mission);
      } else {
        selectedMissions.add(mission);
      }
    });
  }

  void _setDifficulty(String value) {
    setState(() {
      difficulty = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('랜덤 미션',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('알람이 울린 뒤 랜덤 미션을 완료해야 알람이 꺼져요'),
            SizedBox(height: 16),
            ...['간단한 수학 문제 풀기', '따라 누르기', '글 따라쓰기'].map((mission) {
              return CheckboxListTile(
                title: Text(mission),
                value: selectedMissions.contains(mission),
                onChanged: (_) => _toggleMission(mission),
              );
            }),
            SizedBox(height: 8),
            Text('난이도'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['상', '중', '하'].map((level) {
                return GestureDetector(
                  onTap: () => _setDifficulty(level),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: difficulty == level
                          ? Colors.brown
                          : Colors.grey.shade200,
                    ),
                    child: Text(level, style: TextStyle(color: Colors.white)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'missions': selectedMissions,
                  'difficulty': difficulty,
                });
              },
              child: Text('설정하기'),
            ),
          ],
        ),
      ),
    );
  }
}
