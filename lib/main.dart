import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifemaster_proj2/screen/alarm_widget.dart';
import 'package:lifemaster_proj2/screen/calender_widget.dart';
import 'package:lifemaster_proj2/screen/challenge_widget.dart';
import 'package:lifemaster_proj2/screen/detox_widget.dart';
import 'package:lifemaster_proj2/screen/self_reflection_widget.dart';
import 'package:lifemaster_proj2/screen/sleep_widget.dart';
import 'package:lifemaster_proj2/screen/todo_widget.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// flutter_local_notifications 초기화
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 타임존 초기화
  tz.initializeTimeZones();

  // 알림 초기화
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
  DateTime _selectedDate = DateTime.now();
  DateTime _alarmTime = DateTime.now(); // 알람 초기 시간
  List<String> activeFeatures = ["달력", "할일", "수면", "자아성찰", "챌린지", "디톡스", "알람"];
  final Map<DateTime, Map<String, dynamic>> _activities = {};

  // 특정 날짜에 해당하는 액티비티 가져오기
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

  // 액티비티 업데이트
  void _updateActivity(String key, dynamic value) {
    setState(() {
      if (_activities.containsKey(_selectedDate)) {
        _activities[_selectedDate]![key] = value;
      }
    });
  }

  // 알림 예약
  void _scheduleAlarm(TimeOfDay time) async {
    final now = DateTime.now();
    final alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final tz.TZDateTime tzDateTime =
        tz.TZDateTime.from(alarmDateTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // ID
      '알람',
      '알람이 울립니다.',
      tzDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id',
          '알람 채널',
          channelDescription: '알람 울림을 위한 채널',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // 알람 업데이트
  void _updateAlarm(TimeOfDay alarmTime) {
    setState(() {
      _alarmTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        alarmTime.hour,
        alarmTime.minute,
      );
    });
    _scheduleAlarm(alarmTime);
  }

  // 날짜 선택
  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  // 활성화된 기능 업데이트
  void _updateActiveFeatures(List<String> features) {
    setState(() {
      activeFeatures = features;
    });
  }

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
            if (activeFeatures.contains("달력")) ...[
              CalendarWidget(
                selectedDate: _selectedDate,
                onDateSelected: _onDateSelected,
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("할일")) ...[
              TodoWidget(
                initialTasks: List<Map<String, dynamic>>.from(
                  _currentActivities['tasks'] as List<Map<String, dynamic>>,
                ),
                onUpdate: (tasks) => _updateActivity('tasks', tasks),
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("수면")) ...[
              SleepWidget(
                sleepData: _currentActivities['sleep'] as String,
                onUpdate: (data) => _updateActivity('sleep', data),
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("자아성찰")) ...[
              SelfReflectionWidget(
                reflectionData: Map<String, dynamic>.from(
                  _currentActivities['reflection'] as Map<String, dynamic>,
                ),
                onUpdate: (data) => _updateActivity('reflection', data),
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("챌린지")) ...[
              ChallengeWidget(
                challengeData: Map<String, dynamic>.from(
                  _currentActivities['challenge'] as Map<String, dynamic>,
                ),
                onUpdate: (data) => _updateActivity('challenge', data),
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("디톡스")) ...[
              DetoxWidget(
                detoxData: Map<String, dynamic>.from(
                  _currentActivities['detox'] as Map<String, dynamic>,
                ),
                onUpdate: (data) => _updateActivity('detox', data),
              ),
              SizedBox(height: 12),
            ],
            if (activeFeatures.contains("알람")) ...[
              AlarmWidget(
                initialAlarmTime: _alarmTime,
                onAlarmSet: _updateAlarm,
              ),
              SizedBox(height: 12),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            final updatedFeatures = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditHomeScreen(activeFeatures: activeFeatures),
              ),
            );

            if (updatedFeatures != null) {
              _updateActiveFeatures(updatedFeatures);
            }
          },
          child: Text("홈 화면 편집"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class EditHomeScreen extends StatelessWidget {
  final List<String> activeFeatures;

  EditHomeScreen({required this.activeFeatures});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("홈 화면 편집")),
      body: ListView(
        children: [
          CheckboxListTile(
            title: Text("달력"),
            value: activeFeatures.contains("달력"),
            onChanged: (bool? value) {
              // 업데이트 로직
            },
          ),
          CheckboxListTile(
            title: Text("할일"),
            value: activeFeatures.contains("할일"),
            onChanged: (bool? value) {
              // 업데이트 로직
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, activeFeatures);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
