import 'package:flutter/material.dart';

class RandomMissionScreen extends StatefulWidget {
  final Map<String, dynamic> initialMission;

  RandomMissionScreen({required this.initialMission});

  @override
  _RandomMissionScreenState createState() => _RandomMissionScreenState();
}

class _RandomMissionScreenState extends State<RandomMissionScreen> {
  String _selectedMission = "";
  String _difficulty = "상"; // 난이도: 상, 중, 하

  @override
  void initState() {
    super.initState();
    if (widget.initialMission.isNotEmpty) {
      _selectedMission = widget.initialMission['name'] ?? "";
      _difficulty = widget.initialMission['difficulty'] ?? "상";
    }
  }

  void _saveMission() {
    Navigator.pop(context, {
      'name': _selectedMission,
      'difficulty': _difficulty,
    });
  }

  Widget _buildDifficultySelector(String difficulty) {
    final isSelected = _difficulty == difficulty;
    return GestureDetector(
      onTap: () {
        setState(() {
          _difficulty = difficulty;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          difficulty,
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
        title: Text("랜덤 미션"),
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
            Text(
              "랜덤 미션",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("알람이 울린 뒤 랜덤미션을 완료해야 알람이 꺼져요"),
            SizedBox(height: 16),
            ListTile(
              title: Text("간단한 수학 문제 풀기"),
              trailing: Radio<String>(
                value: "간단한 수학 문제 풀기",
                groupValue: _selectedMission,
                onChanged: (value) {
                  setState(() {
                    _selectedMission = value!;
                  });
                },
              ),
            ),
            if (_selectedMission == "간단한 수학 문제 풀기") ...[
              SizedBox(height: 8),
              Text("난이도"),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    ["상", "중", "하"].map(_buildDifficultySelector).toList(),
              ),
            ],
            ListTile(
              title: Text("따라 누르기"),
              trailing: Radio<String>(
                value: "따라 누르기",
                groupValue: _selectedMission,
                onChanged: (value) {
                  setState(() {
                    _selectedMission = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("글 따라쓰기"),
              trailing: Radio<String>(
                value: "글 따라쓰기",
                groupValue: _selectedMission,
                onChanged: (value) {
                  setState(() {
                    _selectedMission = value!;
                  });
                },
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _saveMission,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade300,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "설정하기",
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
