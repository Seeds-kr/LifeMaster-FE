import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 패키지 임포트
import 'repetition_lock_screen.dart';
import 'time_lock_screen.dart';

class LockSelectionScreen extends StatefulWidget {
  @override
  _LockSelectionScreenState createState() => _LockSelectionScreenState();
}

class _LockSelectionScreenState extends State<LockSelectionScreen> {
  String _selectedOption = "반복잠금"; // 기본 옵션
  int _selectedIndex = 0; // 네비게이션 바에서 선택된 인덱스

  // 각 페이지를 위한 List
  final List<Widget> _pages = [
    RepetitionLockScreen(),
    TimeLockScreen(),
    // 추가할 페이지들
    Center(child: Text("홈 페이지")),
    Center(child: Text("그룹 페이지")),
    Center(child: Text("커뮤니티 페이지")),
  ];

  // 네비게이션 바에서 아이템 클릭 시 화면 전환
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 반복잠금과 시간잠금 버튼 클릭 시 해당 화면으로 전환
  void _onOptionTapped(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0), // 이미지 주변 여백
          child: SvgPicture.asset(
            'assets/images/lock_icon.svg', // SVG 이미지 경로
            width: 24,  // 너비 24로 설정
            height: 24, // 높이 24로 설정
            fit: BoxFit.none, // 이미지 크기 조정
          ),
        ),
        title: const Text(
          "디톡스",
          style: TextStyle(
            fontSize: 20,  // 글씨 크기 설정
            fontWeight: FontWeight.bold,  // 볼드체 설정
          ),
        ),
        titleSpacing: -8.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 280,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: const Color(0xFFF0F4F5), width: 1.5),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onOptionTapped("반복잠금");
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.center,  // 텍스트를 중앙에 배치
                      decoration: BoxDecoration(
                        color: _selectedOption == "반복잠금"
                            ? const Color(0xFFB4D775)
                            : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(
                          left: const Radius.circular(30),
                          right: _selectedOption == "반복잠금"
                              ? const Radius.circular(30)
                              : Radius.zero,
                        ),
                      ),
                      child: Text(
                        "반복잠금",
                        style: TextStyle(
                          color: _selectedOption == "반복잠금"
                              ? Colors.white
                              : const Color(0xFFF0F4F5),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onOptionTapped("시간잠금");
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      alignment: Alignment.center,  // 텍스트를 중앙에 배치
                      decoration: BoxDecoration(
                        color: _selectedOption == "시간잠금"
                            ? const Color(0xFFB4D775)
                            : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(
                          left: _selectedOption == "시간잠금"
                              ? const Radius.circular(30)
                              : Radius.zero,
                          right: const Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        "시간잠금",
                        style: TextStyle(
                          color: _selectedOption == "시간잠금"
                              ? Colors.white
                              : const Color(0xFFF0F4F5),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 선택된 화면을 표시
          Expanded(
            child: _selectedOption == "반복잠금"
                ? RepetitionLockScreen()
                : TimeLockScreen(),
          ),
        ],
      ),
      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // 탭할 때마다 인덱스 업데이트
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '그룹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: '전체',
          ),
        ],
      ),
    );
  }
}
