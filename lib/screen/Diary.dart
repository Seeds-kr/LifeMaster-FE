import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/diary_entry.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final List<DiaryEntry> _diaryEntries = [
    DiaryEntry(DateTime.now(), diary: "오늘은 날씨가 좋았다.", gratitude: ["가족과 함께", "좋은 음식", "운동을 했다"]),
  ];

  DiaryEntry _getEntryForSelectedDay() {
    return _diaryEntries.firstWhere(
          (entry) => isSameDay(entry.date, _selectedDay),
      orElse: () => DiaryEntry(_selectedDay),
    );
  }

  bool _showDiary = true;

  void _saveDiaryEntry(DiaryEntry entry) {
    setState(() {
      // 해당 날짜의 일기 또는 감사 내용 업데이트
      int index = _diaryEntries.indexWhere((e) => isSameDay(e.date, entry.date));
      if (index != -1) {
        _diaryEntries[index] = entry; // 이미 존재하는 항목을 업데이트
      } else {
        _diaryEntries.add(entry); // 새 항목 추가
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DiaryEntry selectedEntry = _getEntryForSelectedDay();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              _showDiary ? 'assets/images/thank_icon.svg' : 'assets/images/diary_icon.svg' , // 조건에 따라 다른 SVG 파일 경로
              height: 24, // 아이콘 높이
              width: 24,  // 아이콘 너비
            ),
            SizedBox(width: 4), // 텍스트와 아이콘 간 간격
            Text(
              '자아성찰',
              style: TextStyle(
                fontSize: 20, // 글씨 크기
                color: Colors.black, // 글씨 색상
                fontWeight: FontWeight.bold, // 글씨 굵기
                fontFamily: 'Roboto', // 폰트 패밀리 (선택 사항)
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 185, 67, 0.3),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: _showDiary
                        ? const Color.fromRGBO(255, 185, 67, 1)
                        : const Color.fromRGBO(244, 219, 145, 1),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  defaultTextStyle: const TextStyle(color: Colors.black),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Divider(),
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
                        setState(() {
                          _showDiary = true;
                        });
                      },
                      child: Container(
                        width: 140,
                        height: 40,
                        alignment: Alignment.center,  // 텍스트를 중앙에 배치
                        decoration: BoxDecoration(
                          color: _showDiary ? const Color(0xFFFFB943) : Colors.transparent,
                          borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(30),
                            right: _showDiary ? const Radius.circular(30) : Radius.zero,
                          ),
                        ),
                        child: Text(
                          "오늘의 일기",
                          style: TextStyle(color: _showDiary ? Colors.white : Colors.black, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showDiary = false;
                        });
                      },
                      child: Container(
                        width: 140,
                        height: 40,
                        alignment: Alignment.center,  // 텍스트를 중앙에 배치
                        decoration: BoxDecoration(
                          color: !_showDiary ? const Color.fromRGBO(244, 219, 145, 1) : Colors.transparent,
                          borderRadius: BorderRadius.horizontal(
                            left: !_showDiary ? const Radius.circular(30) : Radius.zero,
                            right: const Radius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "5 감사",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_showDiary)
              DiaryScreenWidget(entry: selectedEntry, saveEntry: _saveDiaryEntry),
            if (!_showDiary)
              GratitudeScreenWidget(entry: selectedEntry, saveEntry: _saveDiaryEntry),
            const SizedBox(height: 16),
            SizedBox(height: 60), // "시작하기" 버튼 높이에 맞는 여백
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 361,
        height: 48,
        child: FloatingActionButton(
          backgroundColor: _showDiary
              ? const Color.fromRGBO(255, 185, 67, 1)
              : const Color.fromRGBO(244, 219, 145, 1),
          onPressed: () {
            _saveDiaryEntry(selectedEntry); // 작성 내용 저장
          },
          child: Text(
            "작성하기",
            style: TextStyle(
              fontSize: 12, // 글씨 크기
              fontFamily: 'Roboto',
              color: _showDiary
                  ? const Color.fromRGBO(255, 255, 255, 1) // 조건에 따라 글씨 색 변경
                  : const Color.fromRGBO(19, 19, 19, 1),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // 화면 아래 중앙에 배치
    );
  }
}

class DiaryScreenWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final DiaryEntry entry;
  final Function(DiaryEntry) saveEntry;

  DiaryScreenWidget({required this.entry, required this.saveEntry, super.key});

  @override
  Widget build(BuildContext context) {
    // Controller를 entry의 내용으로 초기화
    _controller.text = entry.diary ?? '';

    return SingleChildScrollView(
      child: Container(
        width: 361,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "오늘의 일기",
              style: TextStyle(fontSize: 12, color: Color.fromRGBO(19, 19, 19, 1), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(240, 244, 245, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                minLines: 10, // 최소 줄 수
                maxLines: null, // 줄 수 제한 없음
                style: const TextStyle(
                  fontSize: 12, // 글씨 크기
                  color: Color.fromRGBO(19, 19, 19, 0.6), // 글씨 색상
                  fontWeight: FontWeight.normal, // 글씨 굵기
                  fontFamily: 'Roboto', // 폰트 패밀리 (선택 사항)
                ),
                decoration: const InputDecoration(
                  hintText: "오늘 하루동안 있었던 일을 적어보세요",
                  hintStyle: TextStyle(fontSize: 12, color: Color.fromRGBO(19, 19, 19, 0.6)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  entry.diary = value;
                },
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class GratitudeScreenWidget extends StatelessWidget {
  final DiaryEntry entry;
  final Function(DiaryEntry) saveEntry;
  final List<TextEditingController> _controllers;

  GratitudeScreenWidget({required this.entry, required this.saveEntry, super.key})
      : _controllers = List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    // Controller들에 gratitude 값을 초기화
    for (int i = 0; i < entry.gratitude.length; i++) {
      _controllers[i].text = entry.gratitude[i];
    }

    return SingleChildScrollView(
      child: Container(
        width: 361,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(5, (index) {
            // 한글로 숫자 표현
            List<String> numberWords = ['첫', '두', '세', '네', '다섯'];
            String gratitudeLabel = '${numberWords[index]} 번째 감사';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(gratitudeLabel,
                    style: const TextStyle(fontSize: 12, color: Color.fromRGBO(19, 19, 19, 1), fontWeight: FontWeight.w500 // 글자 두께 설정 (bold보다 덜 두껍게)
                )),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(240, 244, 245, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    minLines: 1, // 최소 줄 수
                    maxLines: null, // 줄 수 제한 없음
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                    ),
                    decoration: const InputDecoration(
                      hintText: "감사한 일을 적어보세요",
                      hintStyle: TextStyle(fontSize: 12, color: Color.fromRGBO(19, 19, 19, 0.6)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 8), // 왼쪽 여백 추가
                    ),
                    onChanged: (value) {
                      entry.gratitude[index] = value;
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          }),
        ),
      ),
    );
  }
}
