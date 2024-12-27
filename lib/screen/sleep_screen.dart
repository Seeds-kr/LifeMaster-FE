import 'package:flutter/material.dart';
import 'dart:async';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  late Timer _timer;
  int _musicElapsedSeconds = 0; // 음악 재생 경과 시간
  int _currentElapsedSeconds = 0; // 페이지에 들어온 이후의 경과 시간
  late DateTime _entryTime; // 페이지에 들어온 시간
  bool _isPlaying = false; // 음악 재생 상태
  double _currentPosition = 0.0; // 재생바 위치
  double _duration = 300.0; // 가상의 음악 길이 (5분)

  @override
  void initState() {
    super.initState();
    _entryTime = DateTime.now(); // 페이지에 들어온 시간을 기록
    _startTimer(); // 타이머 시작
  }

  // 타이머 함수
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // 페이지에 들어온 이후의 경과 시간은 항상 증가
        _currentElapsedSeconds++;

        if (_isPlaying) {
          // 음악 재생 경과 시간만 재생 중일 때 증가
          _musicElapsedSeconds++;
          _musicElapsedSeconds = _musicElapsedSeconds > _duration ? _duration.toInt() : _musicElapsedSeconds;

          // 재생바 위치도 음악 재생 경과 시간에 맞게 업데이트
          _currentPosition = _musicElapsedSeconds.toDouble();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머 취소
    super.dispose();
  }

  // 시간을 "00:00" 형식으로 변환하는 함수
  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}'; // '00:00' 형식으로 반환
  }

  // 현재 페이지에 들어온 시간부터의 경과 시간 표시
  String _formatEntryTime() {
    Duration diff = DateTime.now().difference(_entryTime);
    String startTime = '${_entryTime.hour}:${_entryTime.minute.toString().padLeft(2, '0')}';
    String endTime = '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';

    // 공백을 추가한 형태로 반환
    String formattedStartTime = startTime.split('').join('     ');
    String formattedEndTime = endTime.split('').join('     ');

    return '$formattedStartTime          ~          $formattedEndTime';
  }

  // 재생/일시정지 토글 함수
  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        // 재생을 시작할 때 타이머를 계속 진행
        _startTimer();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final Map<String, String>? item = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('수면'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: item == null
            ? Center(child: Text('재생할 항목이 없습니다.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You Slept', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  _formatTime(_currentElapsedSeconds).split(':')[0],
                  style: TextStyle(fontSize: 80),
                ),
                Text('h', style: TextStyle(fontSize: 40)),
                SizedBox(width: 4),
                Text(
                  _formatTime(_currentElapsedSeconds).split(':')[1],
                  style: TextStyle(fontSize: 80),
                ),
                Text('min', style: TextStyle(fontSize: 40)),
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: 361,
              height: 48,
              decoration: BoxDecoration(
                color: Color.fromRGBO(51, 51, 51, 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _formatEntryTime(),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 361,
              child: Column(
                children: [
                  Text(item['title'] ?? '제목 없음', style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
                  SizedBox(height: 8),
                  Slider(
                    value: _currentPosition,
                    min: 0,
                    max: _duration,
                    onChanged: (value) {
                      setState(() {
                        _currentPosition = value; // 슬라이더 값만 변경
                        _musicElapsedSeconds = value.toInt(); // 슬라이더 위치에 맞게 음악 경과 시간 조정
                      });
                    },
                    inactiveColor: Colors.grey,
                    activeColor: Color(0xFF333333),
                    thumbColor: Color(0xFF333333),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 24),
                        onPressed: _togglePlayPause,
                      ),
                      IconButton(
                        icon: Icon(Icons.stop, size: 24),
                        onPressed: () {
                          setState(() {
                            _isPlaying = false;
                            _currentPosition = 0.0;
                            _musicElapsedSeconds = 0;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
