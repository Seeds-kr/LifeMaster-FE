import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/diary_entry.dart';

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
        title: const Text('자아성찰'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: _showDiary
                        ? const Color.fromRGBO(255, 185, 67, 1)
                        : const Color.fromRGBO(244, 219, 145, 1),
                    borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
          child: const Text("작성하기"),
        ),
      ),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "오늘 하루동안 있었던 일을 적어보세요",
                  hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(19, 19, 19, 0.6)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  entry.diary = value;
                },
              ),
            ),
            const SizedBox(height: 60),
            // 저장된 내용 표시
            if (entry.diary != null && entry.diary!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "저장된 내용: ${entry.diary}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class GratitudeScreenWidget extends StatelessWidget {
  final DiaryEntry entry;
  final Function(DiaryEntry) saveEntry;
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

  GratitudeScreenWidget({required this.entry, required this.saveEntry, super.key});

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
            String gratitudeLabel = '감사한 일 ${index + 1}';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(gratitudeLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(240, 244, 245, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "오늘 감사한 일을 적어보세요",
                      hintStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(19, 19, 19, 0.6)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      entry.gratitude[index] = value;
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
