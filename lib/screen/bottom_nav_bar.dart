import 'package:flutter/material.dart';
import 'package:lifemaster_proj2/main.dart';
import 'package:lifemaster_proj2/screen/challenge_widget.dart';
import 'package:lifemaster_proj2/screen/edit_home_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // 화면 위젯 목록, 필요한 매개변수를 추가하여 설정
  final List<Widget> _screens = [
    LifeMasterHomePage(), // 홈 화면
    ChallengeWidget(
      challengeData: {}, // 초기값 설정
      onUpdate: (data) {}, // 업데이트 함수
    ),
    // CommunityWidget(), // CommunityWidget이 정의되면 여기에 추가
    EditHomeScreen(
      activeFeatures: [
        "달력",
        "할일",
        "수면",
        "자아성찰",
        "챌린지",
        "디톡스",
        "알람"
      ], // 초기 activeFeatures 설정
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '그룹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: '전체',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
