import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool _showDiary = true; // 일기와 감사 UI 전환
  DateTime _selectedDate = DateTime.now();
  Map<String, String> _selfReflectionData = {
    'diaryContent': '',
    'thankOne': '',
    'thankTwo': '',
    'thankThree': '',
    'thankFour': '',
    'thankFive': '',
  };
  bool _hasData = false; // 데이터 유무 상태
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.2.2.2:8080'));

  // API 호출 함수
  Future<void> _fetchSelfReflection(DateTime date) async {
    try {
      String formattedDate = "${date.year}-${date.month.toString().padLeft(
          2, '0')}-${date.day.toString().padLeft(2, '0')}";
      final response = await _dio.get(
        '/schedule/self-reflection',
        queryParameters: {'date': formattedDate},
      );

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          _selfReflectionData = {
            'diaryContent': response.data['diaryContent'] ?? '',
            'thankOne': response.data['thankOne'] ?? '',
            'thankTwo': response.data['thankTwo'] ?? '',
            'thankThree': response.data['thankThree'] ?? '',
            'thankFour': response.data['thankFour'] ?? '',
            'thankFive': response.data['thankFive'] ?? '',
          };
          _hasData = true;
        });
      } else {
        setState(() {
          _hasData = false;
        });
      }
    } catch (e) {
      print('Error fetching self-reflection: $e');
      setState(() {
        _hasData = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data for the selected date.')),
      );
    }
  }

  // 감사 내용 데이터 POST 함수
  Future<void> _postThankData(Map<String, String> thankData) async {
    try {
      String formattedDate = "${_selectedDate.year}-${_selectedDate.month
          .toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(
          2, '0')}";
      final response = await _dio.post(
        '/schedule/self-reflection/thank',
        data: {
          'thankDate': formattedDate,
          'thankOne': thankData['thankOne'],
          'thankTwo': thankData['thankTwo'],
          'thankThree': thankData['thankThree'],
          'thankFour': thankData['thankFour'],
          'thankFive': thankData['thankFive'],
        },
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thank data submitted successfully!')),
        );
      }
    } catch (e) {
      print('Error submitting thank data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit thank data.')),
      );
    }
  }

// 일기 내용 데이터 POST 함수
  Future<void> _postDiaryData(String diaryContent) async {
    try {
      String formattedDate = "${_selectedDate.year}-${_selectedDate.month
          .toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(
          2, '0')}";
      final response = await _dio.post(
        '/schedule/self-reflection/diary',
        data: {
          'diaryDate': formattedDate,
          'diaryContent': diaryContent,
        },
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Diary content submitted successfully!')),
        );
      }
    } catch (e) {
      print('Error submitting diary content: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit diary content.')),
      );
    }
  }

  // 오늘 날짜와 비교하는 함수
  bool _isToday(DateTime date) {
    DateTime today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  @override
  void initState() {
    super.initState();
    _fetchSelfReflection(_selectedDate); // 초기 화면 로드 시 오늘 날짜 데이터 확인
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController diaryController = TextEditingController();
    TextEditingController thankOneController = TextEditingController();
    TextEditingController thankTwoController = TextEditingController();
    TextEditingController thankThreeController = TextEditingController();
    TextEditingController thankFourController = TextEditingController();
    TextEditingController thankFiveController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        title: Row(
          children: [
            SvgPicture.asset(
              _showDiary
                  ? 'assets/images/thank_icon.svg'
                  : 'assets/images/diary_icon.svg', // 조건에 따라 다른 SVG 파일 경로
              height: 24, // 아이콘 높이
              width: 24, // 아이콘 너비
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TableCalendar(
              // TableCalendar 위젯
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
              onDaySelected: (selectedDay, focusedDay) {
                if (selectedDay.isAfter(DateTime.now())) {
                  // 클릭 불가능한 날짜는 무시
                  return;
                }
                setState(() {
                  _selectedDate = selectedDay;
                });
                _fetchSelfReflection(selectedDay);
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 185, 67, 0),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.black),
                selectedDecoration: BoxDecoration(
                  color: _showDiary
                      ? const Color.fromRGBO(255, 185, 67, 0.3)
                      : const Color.fromRGBO(244, 219, 145, 0.3),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.black),
                defaultTextStyle: const TextStyle(color: Colors.black),
                weekendTextStyle: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (_hasData) ...[
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //오늘의 일기
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/thank_icon.svg', // 조건에 따라 다른 SVG 파일 경로
                          height: 16, // 아이콘 높이
                          width: 16,  // 아이콘 너비
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '오늘의 일기',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity, // 너비를 Fill로 설정
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                        borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                        child: Text(
                          _selfReflectionData['diaryContent'] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                          ),
                          softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                        ),
                      ),
                    ),

                    // 5감사
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/diary_icon.svg', // 조건에 따라 다른 SVG 파일 경로
                          height: 16, // 아이콘 높이
                          width: 16,  // 아이콘 너비
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '오늘의 감사',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식 위젯들을 양 끝으로 배치
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16), // 좌우 28, 상하 20 패딩
                          child: Text('1.'),
                        ),
                        Container(
                          width: 321,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                            borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                            child: Text(
                              _selfReflectionData['thankOne'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                              ),
                              softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식 위젯들을 양 끝으로 배치
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16), // 좌우 28, 상하 20 패딩
                          child: Text('2.'),
                        ),
                        Container(
                          width: 321,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                            borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                            child: Text(
                              _selfReflectionData['thankTwo'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                              ),
                              softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식 위젯들을 양 끝으로 배치
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16), // 좌우 28, 상하 20 패딩
                          child: Text('3.'),
                        ),
                        Container(
                          width: 321,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                            borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                            child: Text(
                              _selfReflectionData['thankThree'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                              ),
                              softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식 위젯들을 양 끝으로 배치
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16), // 좌우 28, 상하 20 패딩
                          child: Text('4.'),
                        ),
                        Container(
                          width: 321,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                            borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                            child: Text(
                              _selfReflectionData['thankFour'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                              ),
                              softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식 위젯들을 양 끝으로 배치
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16), // 좌우 28, 상하 20 패딩
                          child: Text('5.'),
                        ),
                        Container(
                          width: 321,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0x99F0F4F5), // 배경색에 투명도 60% 적용
                            borderRadius: BorderRadius.circular(8), // 둥근 모서리 적용
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 좌우 28, 상하 20 패딩
                            child: Text(
                              _selfReflectionData['thankFive'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x99131313), // 텍스트 색상에 투명도 60% 적용
                              ),
                              softWrap: true, // 텍스트가 길어지면 자동으로 줄 바꿈 처리
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ] else if (_isToday(_selectedDate)) ...[
            // 오늘 날짜이고 데이터가 없을 경우 작성 화면 표시
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
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  controller: diaryController,
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
                            // children: List.generate(5, (index) {
                            //   List<String> numberWords = ['첫', '두', '세', '네', '다섯'];
                            //   String gratitudeLabel = '${numberWords[index]} 번째 감사';
                            //
                            //   return Column(
                            //     crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '첫 번째 감사',
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
                                  controller: thankOneController,
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
                              Text(
                                '두 번째 감사',
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
                                  controller: thankTwoController,
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
                              Text(
                                '세 번째 감사',
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
                                  controller: thankThreeController,
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

                              Text(
                                '네 번째 감사',
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
                                  controller: thankFourController,
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

                              Text(
                                '다섯 번째 감사',
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
                                  controller: thankFiveController,
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
                          ),
                          // }),
                        ),

                    ],
                  ),

                )),
            Align(
              alignment: Alignment.bottomCenter, // 화면 하단 중앙에 정렬
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0), // 하단에서 50px 위로 올리기
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: _showDiary
                        ? const Color.fromRGBO(255, 185, 67, 1)
                        : const Color.fromRGBO(244, 219, 145, 1),
                    minimumSize: Size(361, 48), // 버튼 크기 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 둥근 모서리
                    ),
                  ),
                  onPressed: () {
                    _postDiaryData(diaryController.text);
                    _postThankData({
                      'thankOne': thankOneController.text,
                      'thankTwo': thankTwoController.text,
                      'thankThree': thankThreeController.text,
                      'thankFour': thankFourController.text,
                      'thankFive': thankFiveController.text,
                    });
                  },
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
            ),

          ] else ...[
            Center(
              child: Text(
                'No data available for the selected date.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]
        ],
      ),
    );
  }
}