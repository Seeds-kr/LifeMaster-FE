import 'package:flutter/material.dart';
import 'package:lifemaster_proj3/screen/alarm_widget.dart';
import 'package:lifemaster_proj3/screen/calender_widget.dart';
import 'package:lifemaster_proj3/screen/challenge_widget.dart';
import 'package:lifemaster_proj3/screen/community_screen.dart'; // 추가된 부분
import 'package:lifemaster_proj3/screen/detox_widget.dart';
import 'package:lifemaster_proj3/screen/self_reflection_widget.dart';
import 'package:lifemaster_proj3/screen/sleep_widget.dart';
import 'package:lifemaster_proj3/screen/todo_widget.dart';

void main() {
  runApp(LifeMasterApp());
}

class LifeMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LifeMasterHomePage(),
    );
  }
}

class LifeMasterHomePage extends StatefulWidget {
  @override
  _LifeMasterHomePageState createState() => _LifeMasterHomePageState();
}

class _LifeMasterHomePageState extends State<LifeMasterHomePage> {
  int _currentIndex = 0;
  DateTime _selectedDate = DateTime.now();
  List<String> activeFeatures = ["달력", "알람", "할일", "수면", "자아성찰", "챌린지", "디톡스"];
  final Map<DateTime, Map<String, dynamic>> _activities = {};

  Map<String, dynamic> get _currentActivities {
    if (!_activities.containsKey(_selectedDate)) {
      _activities[_selectedDate] = {
        'tasks': <Map<String, dynamic>>[],
        'sleep': "수면 정보 없음",
        'reflection': <String, dynamic>{},
        'challenge': <String, dynamic>{},
        'detox': <String, dynamic>{},
      };
    }
    return _activities[_selectedDate]!;
  }

  void _updateActivity(String key, dynamic value) {
    setState(() {
      if (_activities.containsKey(_selectedDate)) {
        _activities[_selectedDate]![key] = value;
      }
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _updateActiveFeatures(List<String> features) {
    setState(() {
      activeFeatures = features;
    });
  }

  final List<Widget> _screens = [
    LifeMasterHomeScreen(),
    CommunityScreen(), // 분리된 커뮤니티 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // 현재 선택된 화면 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: "커뮤니티",
          ),
        ],
      ),
    );
  }
}

// **홈 화면을 분리한 위젯 (기존 코드 유지)**
class LifeMasterHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F7),
      appBar: AppBar(
        title: Text("LifeMaster"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarWidget(
              selectedDate: DateTime.now(),
              onDateSelected: (date) {},
            ),
            SizedBox(height: 12),
            AlarmWidget(
                initialAlarmTime: DateTime.now(), onAlarmSet: (time) {}),
            SizedBox(height: 12),
            TodoWidget(initialTasks: [], onUpdate: (tasks) {}),
            SizedBox(height: 12),
            SleepWidget(sleepData: "수면 정보 없음", onUpdate: (data) {}),
            SizedBox(height: 12),
            SelfReflectionWidget(reflectionData: {}, onUpdate: (data) {}),
            SizedBox(height: 12),
            ChallengeWidget(challengeData: {}, onUpdate: (data) {}),
            SizedBox(height: 12),
            DetoxWidget(detoxData: {}, onUpdate: (data) {}),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
