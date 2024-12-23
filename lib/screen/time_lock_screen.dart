import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 첫 번째 숫자 (시간) 입력 제한: 01 ~ 12
// 시간 입력 제한 (01 ~ 12)
class HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final intValue = int.tryParse(newValue.text);
    if (intValue != null && intValue >= 1 && intValue <= 12) {
      return newValue;
    }
    if (newValue.text.isEmpty) {
      return newValue;
    }
    return oldValue;
  }
}

// 분 입력 제한 (00 ~ 59)
class MinuteInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final intValue = int.tryParse(newValue.text);
    if (intValue != null && intValue >= 0 && intValue <= 59) {
      return newValue;
    }
    if (newValue.text.isEmpty) {
      return newValue;
    }
    return oldValue;
  }
}

class TimeLockScreen extends StatefulWidget {
  @override
  _TimeLockScreenState createState() => _TimeLockScreenState();
}

class _TimeLockScreenState extends State<TimeLockScreen> {
  String _elapsedTime = "00:00:00"; // 초기 누적 시간을 0으로 설정
  String _selectedPeriod = '매주'; // 기본값
  String _selectedDay = '월요일'; // 기본값

  // 글자 입력 상태 관리
  String _startHour = ''; // 시작 시간 (01~12)
  String _startMinute = ''; // 시작 분 (00~59)
  String _endHour = ''; // 종료 시간 (01~12)
  String _endMinute = ''; // 종료 분 (00~59)
  bool _isAM = true; // 시작 시간 AM/PM 상태 (true = AM, false = PM)
  bool _isEndAM = true; // 종료 시간 AM/PM 상태 (true = AM, false = PM)

  List<String> _lockedTimes = []; // 시간 잠금 설정 리스트

  // TextEditingController 선언
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _startMinuteController = TextEditingController();
  final TextEditingController _endHourController = TextEditingController();
  final TextEditingController _endMinuteController = TextEditingController();


  int _parseInt(String value) {
    // 값이 빈 문자열일 경우 0을 반환하거나 적절한 기본값을 설정
    if (value.isEmpty) {
      return 0;
    }
    return int.tryParse(value) ?? 0; // 숫자가 아니면 0 반환
  }

  // 종료시간이 시작시간보다 뒤에 있는지 확인
  bool _isEndTimeValid() {
    int startHour = _parseInt(_startHour); // _startHour가 빈 문자열이면 0으로 처리
    int startMinute = _parseInt(_startMinute);
    int endHour = _parseInt(_endHour);
    int endMinute = _parseInt(_endMinute);

    // AM/PM을 고려하여 시간을 24시간제로 변환
    if (!_isAM) startHour += 12; // 시작 시간이 PM일 경우 12시간 더함
    if (!_isEndAM) endHour += 12; // 종료 시간이 PM일 경우 12시간 더함

    // 시작 시간이 AM일 때 종료 시간이 PM이면 허용
    if (_isAM && !_isEndAM) {
      return true; // AM에서 PM으로 넘어가므로 종료시간은 언제든 유효
    }

    // 시작 시간과 종료 시간이 같은 AM/Pm 상태일 때
    if (_isAM == _isEndAM) {
      if (endHour > startHour || (endHour == startHour && endMinute > startMinute)) {
        return true; // 종료 시간이 시작 시간보다 크면 유효
      }
    }

    // 시작 시간이 PM이고 종료 시간이 AM인 경우는 불가능
    if (!_isAM && _isEndAM) {
      return false; // PM에서 AM으로 넘어가는 것은 불가능
    }

    return false; // 그 외의 경우는 유효하지 않음
  }

  // 팝업에서 입력된 데이터를 처리하는 함수
  void _addTimeLock(String period, String day, String startTime, String endTime) {
    setState(() {
      _lockedTimes.add('$period $day   $startTime ~ $endTime');
    });
  }

  // 항목을 삭제하는 함수
  void _removeTimeLock(int index) {
    setState(() {
      _lockedTimes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 스크롤 가능한 내용
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // 화면 상단에 배치
              children: [
                // '오늘 누적 시간' 텍스트와 시간 표시
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 8.0), // 위쪽 여백 추가
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "오늘 누적 시간",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0x99131313),
                        ),
                      ),
                      Text(
                        _elapsedTime, // 누적 시간 표시
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0x99131313),  // 시간 색상
                        ),
                      ),
                    ],
                  ),
                ),

                // 누적 시간 아래에 bar.svg 추가
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0), // 위쪽 여백 추가
                  child: SvgPicture.asset(
                    'assets/images/bar.svg', // bar.svg 파일 경로
                    width: 10,  // 원하는 너비
                    height: 20,  // 원하는 높이
                  ),
                ),

                // '허용할 서비스'와 오른쪽 편집 버튼
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "차단할 서비스",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,  // 볼드체 설정
                          color: Color(0xFF131313),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // '편집' 버튼 클릭 시 편집 팝업창 띄우기
                          _showEditDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB4D775),  // 버튼 배경 색상
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),  // 버튼 내부 여백 설정 (텍스트 크기에 맞춰 크기 조정)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),  // 모서리 반경 (버튼의 둥글기)
                          ),
                          minimumSize: Size(0, 0),
                        ),
                        child: const Text(
                          '편집',
                          style: TextStyle(
                            fontSize: 12,  // 글자 크기
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // '허용할 서비스'의 내용이 가로, 세로 크기에 맞게 확장
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),  // 양쪽 여백 추가
                  child: Container(
                    width: double.infinity,  // 부모 크기에 맞게 확장
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),  // 좌우 여백 추가
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "차단할 앱", // 실제 허용할 서비스 목록을 표시
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0x99131313),
                        ),
                      ),
                    ),
                  ),
                ),

                // '시간잠금 서비스'와 오른쪽 추가 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "시간 잠금 설정",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,  // 볼드체 설정
                          color: Color(0xFF131313),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // '추가' 버튼 클릭 시 시간 잠금 설정 팝업 띄우기
                          _showTimeLockDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB4D775),  // 버튼 배경 색상
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),  // 버튼 내부 여백 설정 (텍스트 크기에 맞춰 크기 조정)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),  // 모서리 반경 (버튼의 둥글기)
                          ),
                          minimumSize: Size(0, 0),
                        ),
                        child: const Text(
                          '추가',
                          style: TextStyle(
                            fontSize: 12,  // 글자 크기
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // '시간잠금 서비스'의 내용이 가로, 세로 크기에 맞게 확장
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // 내부 스크롤 비활성화
                      itemCount: _lockedTimes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0), // 아이템 간격 조정
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 좌우 끝에 배치
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0), // 텍스트 왼쪽 여백 추가
                                child: Expanded(
                                  child: Text(
                                    _lockedTimes[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/trash.svg', // SVG 파일 경로
                                  width: 12, // 아이콘 크기
                                  height: 12, // 아이콘 크기
                                ),
                                onPressed: () {
                                  _removeTimeLock(index); // 해당 항목 삭제
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // '시간잠금 서비스'와 시작하기 버튼 사이에 여백 추가
                SizedBox(height: 80), // "시작하기" 버튼 높이에 맞는 여백
              ],
            ),
          ),
        ),
        // 시작하기 버튼을 하단에 고정
        Positioned(
          bottom: 16.0, // 화면 하단에 16px 여백을 둡니다
          left: 16.0, // 왼쪽에 여백을 추가
          right: 16.0, // 오른쪽에 여백을 추가
          child: ElevatedButton(
            onPressed: () {
              // 시작하기 버튼 클릭 시 동작
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB4D775),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text(
              "시작하기",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // 편집 팝업을 띄우는 함수
  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모서리 둥글게 설정
          ),
          contentPadding: const EdgeInsets.all(20), // 팝업 전체에 패딩 추가
          content: Container(
            width: 320,
            height: 377, // 팝업 전체 높이 설정
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "차단할 서비스 설정",
                  style: TextStyle(
                    fontSize: 18, // 크기 설정
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10), // 위 텍스트와 간격
                Text(
                  "집중모드 시간에 아래의 앱들을 사용할 수 없어요",
                  style: TextStyle(
                    fontSize: 14, // 크기 설정
                    color: Colors.grey, // 색상 설정 (선택사항)
                  ),
                ),
                SizedBox(height: 20), // 아래 콘텐츠와 간격
                // 추가적인 편집 UI 요소를 여기에 추가
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼 간격 조정
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 팝업 닫기
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF7F7F7), // 취소 버튼 색상 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 모서리 반경 8 설정
                      ),
                      minimumSize: Size(double.infinity, 48), // 버튼 높이 48로 설정
                    ),
                    child: const Text(
                      "취소하기",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black, // 텍스트 색상
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // 버튼 사이 간격
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 적용 버튼의 동작 추가
                      Navigator.of(context).pop(); // 팝업 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB4D775), // 적용 버튼 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 둥근 모서리
                      ),
                      minimumSize: Size(double.infinity, 48), // 버튼 높이 48로 설정
                    ),
                    child: const Text(
                      "적용하기",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }




  // 시간 잠금 설정 팝업을 띄우는 함수
  void _showTimeLockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // 드롭다운과 버튼 상태를 관리하기 위해 StatefulBuilder 사용
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(20),
              content: Container(
                width: 320,
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "반복 잠금 설정",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "설명 첫줄 작성해주세요",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const Text(
                      "설명 두번째 줄 작성해주세요",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                value: _selectedPeriod, // 현재 선택된 값
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                                items: const [
                                  DropdownMenuItem(value: '매주', child: Text('매주')),
                                  DropdownMenuItem(value: '격주', child: Text('격주')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPeriod = value!; // 값이 변경될 때 상태 업데이트
                                  });
                                },
                                dropdownColor: const Color(0xFFF7F7F7),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 76.0),
                                  child: Icon(Icons.arrow_drop_down, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                value: _selectedDay, // 현재 선택된 값
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                                items: const [
                                  DropdownMenuItem(value: '월요일', child: Text('월요일')),
                                  DropdownMenuItem(value: '화요일', child: Text('화요일')),
                                  DropdownMenuItem(value: '수요일', child: Text('수요일')),
                                  DropdownMenuItem(value: '목요일', child: Text('목요일')),
                                  DropdownMenuItem(value: '금요일', child: Text('금요일')),
                                  DropdownMenuItem(value: '토요일', child: Text('토요일')),
                                  DropdownMenuItem(value: '일요일', child: Text('일요일')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDay = value!; // 값이 변경될 때 상태 업데이트
                                  });
                                },
                                dropdownColor: const Color(0xFFF7F7F7),
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 60.0),
                                  child: Icon(Icons.arrow_drop_down, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // bar.svg 이미지 추가
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/bar.svg', // 이미지 경로 설정
                        height: 24, // 이미지 높이 설정
                        width: 50,  // 이미지 너비 설정
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("시작시간", style: TextStyle(fontSize: 12)),
                        Container(
                          height: 32,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _startHourController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: [HourInputFormatter()], // 시간 입력 제한
                            onChanged: (value) {
                              setState(() {
                                _startHour = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14), // 수평, 수직 여백 조정
                              counterText: "",
                            ),
                            textAlign: TextAlign.center, // 텍스트를 중앙에 위치
                            style: TextStyle(
                              fontSize: 12, // 글씨 크기 설정
                              color: Colors.black, // 글씨 색상 설정 (필요에 따라 조정)
                            ),
                          ),
                        ),
                        const Text(":", style: TextStyle(fontSize: 12)),
                        Container(
                          height: 32,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _startMinuteController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: [MinuteInputFormatter()], // 분 입력 제한
                            onChanged: (value) {
                              setState(() {
                                _startMinute = value;
                              });
                            },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14), // 수평, 수직 여백 조정
                                counterText: "",
                              ),
                              textAlign: TextAlign.center, // 텍스트를 중앙에 위치
                              style: TextStyle(
                                fontSize: 12, // 글씨 크기 설정
                                color: Colors.black, // 글씨 색상 설정 (필요에 따라 조정)
                              ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAM = !_isAM;
                            });
                          },
                          child: Container(
                            height: 31,
                            width: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFAFDA78),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                _isAM ? "AM" : "PM",
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // 종료시간
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("종료시간", style: TextStyle(fontSize: 12)),
                        Container(
                          height: 32,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _endHourController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: [HourInputFormatter()],
                            onChanged: (value) {
                              setState(() {
                                _endHour = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14), // 수평, 수직 여백 조정
                              counterText: "",
                            ),
                            textAlign: TextAlign.center, // 텍스트를 중앙에 위치
                            style: TextStyle(
                              fontSize: 12, // 글씨 크기 설정
                              color: Colors.black, // 글씨 색상 설정 (필요에 따라 조정)
                            ),
                          ),
                        ),
                        const Text(":", style: TextStyle(fontSize: 12)),
                        Container(
                          height: 32,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _endMinuteController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: [MinuteInputFormatter()],
                            onChanged: (value) {
                              setState(() {
                                _endMinute = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14), // 수평, 수직 여백 조정
                              counterText: "",
                            ),
                            textAlign: TextAlign.center, // 텍스트를 중앙에 위치
                            style: TextStyle(
                              fontSize: 12, // 글씨 크기 설정
                              color: Colors.black, // 글씨 색상 설정 (필요에 따라 조정)
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEndAM  = !_isEndAM ;
                            });
                          },
                          child: Container(
                            height: 31,
                            width: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFAFDA78),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                _isEndAM  ? "AM" : "PM",
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 종료시간 유효성 검사 결과
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _isEndTimeValid() ? "종료시간이 유효합니다." : "종료시간이 시작시간보다 뒤에 있어야 합니다.",
                        style: TextStyle(
                          color: _isEndTimeValid() ? Colors.green : Colors.red,
                          fontSize: 12, // 글씨 크기 설정
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          // 상태 초기화
                          setState(() {
                            _startHourController.clear();
                            _startMinuteController.clear();
                            _endHourController.clear();
                            _endMinuteController.clear();
                            _selectedPeriod = '매주';
                            _selectedDay = '월요일';
                            _isAM = true;
                            _isEndAM = true;
                          });

                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text(
                          "취소하기",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isEndTimeValid() ? () {
                          // AM/PM 상태를 활용하여 시간 문자열 생성
                          String formatTime(String hour, String minute, bool isAM) {
                            String period = isAM ? "AM" : "PM";
                            return '${hour.padLeft(2, '0')}:${minute.padLeft(2, '0')} $period';
                          }

                          // 시작 시간과 종료 시간 변환
                          String startTime = formatTime(_startHour, _startMinute, _isAM);
                          String endTime = formatTime(_endHour, _endMinute, _isEndAM);

                          // 추가하기 버튼 동작
                          _addTimeLock(_selectedPeriod, _selectedDay, startTime, endTime);

                          Navigator.of(context).pop();

                          // 상태 초기화
                          setState(() {
                            _startHourController.clear();
                            _startMinuteController.clear();
                            _endHourController.clear();
                            _endMinuteController.clear();
                            _selectedPeriod = '매주';
                            _selectedDay = '월요일';
                            _isAM = true;
                            _isEndAM = true;
                          });

                        } : null, // 유효하지 않으면 null로 설정하여 버튼 비활성화
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB4D775),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text(
                          "추가하기",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

}
