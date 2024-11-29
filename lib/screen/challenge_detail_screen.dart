import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/bottom_navigation.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final String title;
  final String image;
  final String date;
  final String description;

  ChallengeDetailScreen({
    required this.title,
    required this.image,
    required this.date,
    required this.description,
  });

  @override
  _ChallengeDetailScreenState createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 제목을 본문에 포함
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 챌린지 이미지
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.image,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16),
                    // TableCalendar로 날짜 선택기 구현
                    TableCalendar(
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      focusedDay: _focusedDay,
                      locale: 'ko-KR',
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        headerTitleBuilder: (context, day) {
                          return Column(
                            children: [
                              Text(
                              DateFormat('MMMM', 'ko_KR').format(day), // 월 이름 표시
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                              DateFormat('y').format(day), // "년" 없이 년도 표시
                              style: TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                          },
                        ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        leftChevronIcon: Icon(Icons.chevron_left, size: 28),
                        rightChevronIcon: Icon(Icons.chevron_right, size: 28),
                      ),
                      calendarStyle: CalendarStyle(
                        todayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                      ),
                    ),
                    SizedBox(height: 16),
                    // 설명
                    Text(
                      widget.title,
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    // 참여하기 버튼
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // 참여하기 기능 구현 (예: API 호출)
                          },
                          child: Text(
                              '참여하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            backgroundColor: Colors.blue[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )
                          ),
                        ),
                      ),
                    ),
                    BottomNavigation(
                      selectedIndex: _selectedIndex,
                      onItemTapped: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
