import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  bool _showDiary = true; // 일기와 감사 UI 전환
  final TextEditingController _diaryController = TextEditingController();
  final List<TextEditingController> _gratitudeControllers = List.generate(
    5,
        (index) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  void dispose() {
    _diaryController.dispose();
    for (var controller in _gratitudeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveDiaryEntry() {
    if (_showDiary) {
      // 일기 저장
      String diaryText = _diaryController.text;
      if (diaryText.isNotEmpty) {
        print("일기 저장: $diaryText");
      } else {
        print("일기가 비어 있습니다.");
      }
    } else {
      // 5 감사 저장
      List<String> gratitudeEntries = _gratitudeControllers
          .map((controller) => controller.text)
          .where((text) => text.isNotEmpty)
          .toList();
      if (gratitudeEntries.isNotEmpty) {
        print("감사 저장: ${gratitudeEntries.join(', ')}");
      } else {
        print("감사 내용이 비어 있습니다.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        title: Row(
          children: [
            SvgPicture.asset(
              _showDiary ? 'assets/images/thank_icon.svg' : 'assets/images/diary_icon.svg' , // 조건에 따라 다른 SVG 파일 경로
              height: 24, // 아이콘 높이
              width: 24,  // 아이콘 너비
            ),
            const SizedBox(width: 4),
            const Text(
              '자아성찰',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 캘린더 UI
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
                  ),
                  selectedDecoration: BoxDecoration(
                    color: _showDiary
                        ? const Color.fromRGBO(255, 185, 67, 1)
                        : const Color.fromRGBO(244, 219, 145, 1),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: const TextStyle(color: Colors.black),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Divider(),

            // 일기와 감사 전환 버튼
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _showDiary
                              ? const Color(0xFFFFB943)
                              : Colors.transparent,
                          borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(30),
                            right: _showDiary
                                ? const Radius.circular(30)
                                : Radius.zero,
                          ),
                        ),
                        child: const Text(
                          "오늘의 일기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !_showDiary
                              ? const Color.fromRGBO(244, 219, 145, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.horizontal(
                            left: !_showDiary
                                ? const Radius.circular(30)
                                : Radius.zero,
                            right: const Radius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "5 감사",
                          style: TextStyle(
                            color: Colors.black,
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
            const SizedBox(height: 16),

            // 일기/감사 UI
            if (_showDiary)
            // 오늘의 일기
              Container(
                width: 361,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "오늘의 일기",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(19, 19, 19, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(240, 244, 245, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _diaryController,
                        minLines: 10,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(19, 19, 19, 0.6),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                        ),
                        decoration: const InputDecoration(
                          hintText: "오늘 하루동안 있었던 일을 적어보세요",
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(19, 19, 19, 0.6),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!_showDiary)
            // 5 감사
              Container(
                width: 361,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(5, (index) {
                    List<String> numberWords = ['첫', '두', '세', '네', '다섯'];
                    String gratitudeLabel = '${numberWords[index]} 번째 감사';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          gratitudeLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(19, 19, 19, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(240, 244, 245, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _gratitudeControllers[index],
                            minLines: 1,
                            maxLines: null,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(19, 19, 19, 0.6),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            ),
                            decoration: const InputDecoration(
                              hintText: "감사한 일을 적어보세요",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(19, 19, 19, 0.6),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),
                ),
              ),
            const SizedBox(height: 60),
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
          onPressed: _saveDiaryEntry,
          child: Text(
            "작성하기",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              color: _showDiary
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : const Color.fromRGBO(19, 19, 19, 1),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
