import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'screen/email_login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/password_reset_screen.dart';
import 'screen/user_info_screen.dart';
import 'screen/sleep_screen.dart';
import 'screen/playlist_screen.dart';
import 'screen/lock_selection_screen.dart';
import 'screen/diary_screen.dart';
import 'screen/menu_screen.dart';
import 'screen/faq_screen.dart';
import 'screen/mypage_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/menu_screen',
      routes: {
        '/': (context) => LoginScreen(), // 로그인, 회원가입
        '/email_login': (context) => EmailLoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/password_reset': (context) => PasswordResetScreen(),
        '/userInfo': (context) => UserInfoScreen(email: '',),
        '/sleep': (context) => SleepScreen(),
        '/playlist': (context) => PlaylistScreen(), // 숙면 플레이리스트
        '/Detox': (context) => LockSelectionScreen(), // 디톡스 디톡스 시간 잠금, 반복 잠금
        '/diary_screen': (context) => DiaryScreen(), // 오늘의 일기, 오감사
        '/menu_screen': (context) => MenuScreen(), //전체 메뉴
        '/faq_screen': (context) => FaqScreen(), //
        '/mypage_screen': (context) => MyPageScreen(), //
      },
    );
  }
}

// import 'package:flutter/material.dart';
// // import 'package:lifemaster_proj2/screen/calender_widget.dart';
// // import 'package:lifemaster_proj2/screen/challenge_widget.dart';
// // import 'package:lifemaster_proj2/screen/detox_widget.dart';
// // import 'package:lifemaster_proj2/screen/self_reflection_widget.dart';
// // import 'package:lifemaster_proj2/screen/sleep_widget.dart';
// // import 'package:lifemaster_proj2/screen/todo_widget.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// void main() {
//   runApp(LifeMasterApp());
// }
//
// class LifeMasterApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LifeMasterHomePage(),
//     );
//   }
// }
//
// class LifeMasterHomePage extends StatefulWidget {
//   @override
//   _LifeMasterHomePageState createState() => _LifeMasterHomePageState();
// }
//
// class _LifeMasterHomePageState extends State<LifeMasterHomePage> {
//   DateTime _selectedDate = DateTime.now();
//
//   // 모든 날짜별 활동을 저장할 `Map`
//   final Map<DateTime, Map<String, dynamic>> _activities = {};
//
//   void _onDateSelected(DateTime date) {
//     setState(() {
//       _selectedDate = date;
//     });
//   }
//
//   Map<String, dynamic> get _currentActivities {
//     // 선택된 날짜의 활동 데이터를 가져오고, 없으면 초기값으로 설정하여 반환
//     if (!_activities.containsKey(_selectedDate)) {
//       _activities[_selectedDate] = {
//         'tasks': <Map<String, dynamic>>[], // 할 일 리스트
//         'sleep': "수면 정보 없음", // 수면 정보
//         'reflection': <String, dynamic>{}, // 자아 성찰
//         'challenge': <String, dynamic>{}, // 챌린지
//         'detox': <String, dynamic>{}, // 디톡스
//       };
//     }
//     return _activities[_selectedDate]!;
//   }
//
//   void _updateActivity(String key, dynamic value) {
//     setState(() {
//       if (_activities.containsKey(_selectedDate)) {
//         _activities[_selectedDate]![key] = value; // 특정 활동 업데이트
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEFF3F7),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CalendarWidget(
//               selectedDate: _selectedDate,
//               onDateSelected: _onDateSelected,
//             ),
//             SizedBox(height: 16),
//             TodoWidget(
//               initialTasks: List<Map<String, dynamic>>.from(
//                   _currentActivities['tasks'] as List<Map<String, dynamic>>),
//               onUpdate: (tasks) => _updateActivity('tasks', tasks),
//             ),
//             SizedBox(height: 16),
//             SleepWidget(
//               sleepData: _currentActivities['sleep'] as String,
//               onUpdate: (data) => _updateActivity('sleep', data),
//             ),
//             SizedBox(height: 16),
//             SelfReflectionWidget(
//               reflectionData: Map<String, dynamic>.from(
//                   _currentActivities['reflection'] as Map<String, dynamic>),
//               onUpdate: (data) => _updateActivity('reflection', data),
//             ),
//             SizedBox(height: 16),
//             ChallengeWidget(
//               challengeData: Map<String, dynamic>.from(
//                   _currentActivities['challenge'] as Map<String, dynamic>),
//               onUpdate: (data) => _updateActivity('challenge', data),
//             ),
//             SizedBox(height: 16),
//             DetoxWidget(
//               detoxData: Map<String, dynamic>.from(
//                   _currentActivities['detox'] as Map<String, dynamic>),
//               onUpdate: (data) => _updateActivity('detox', data),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }