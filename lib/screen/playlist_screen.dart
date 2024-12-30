import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistScreen extends StatelessWidget {
  final List<Map<String, String>> playlistItems1 = [
    {
      'title': '백색소음 - 바람 소리',
      'duration': '01:30:00',
      'description': '자연 속 바람 소리를 들으며 편안한 수면을 취해보세요.',
    },
    {
      'title': '빗소리 - 차분한 밤',
      'duration': '02:00:00',
      'description': '비 오는 날의 차분한 소리가 숙면을 도와줍니다.',
    },
    {
      'title': '파도 소리 - 해변의 평화',
      'duration': '01:45:00',
      'description': '해변의 파도 소리로 편안한 수면을 도와드립니다.',
    },
  ];

  final List<Map<String, String>> playlistItems2 = [
    {
      'title': '빗소리 - 차분한 밤',
      'duration': '02:00:00',
      'description': '비 오는 날의 차분한 소리가 숙면을 도와줍니다.',
    },
    {
      'title': '파도 소리 - 해변의 평화',
      'duration': '01:45:00',
      'description': '해변의 파도 소리로 편안한 수면을 도와드립니다.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/sleep_icon.svg', // SVG 파일 경로
              height: 24, // 아이콘 높이
              width: 24,  // 아이콘 너비
            ),
            SizedBox(width: 4), // 텍스트와 아이콘 간 간격
            Text(
              '숙면 플레이리스트',
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
            // 첫 번째 박스
            PlaylistBox(
              playlistItems: playlistItems1,
              title: '플레이리스트 1',
            ),
            // 두 번째 박스
            PlaylistBox(
              playlistItems: playlistItems2,
              title: '플레이리스트 2',
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistBox extends StatefulWidget {
  final List<Map<String, String>> playlistItems;
  final String title;

  PlaylistBox({required this.playlistItems, required this.title});

  @override
  _PlaylistBoxState createState() => _PlaylistBoxState();
}

class _PlaylistBoxState extends State<PlaylistBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     blurRadius: 4,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          // 제목 (14px)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // 리스트 항목들 (각 항목 높이 80px)
          Column(
            children: widget.playlistItems
                .take(_isExpanded ? widget.playlistItems.length : 2)
                .map((item) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80, // 각 항목 높이 80px
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: PlaylistItem(
                      title: item['title']!,
                      duration: item['duration']!,
                      description: item['description']!,
                      onPlayPressed: () {
                        // 수면 페이지로 데이터 전달하며 이동
                        Navigator.pushNamed(
                          context,
                          '/sleep',
                          arguments: item,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12), // 항목 사이의 간격 12px
                ],
              );
            }).toList(),
          ),
          // "더보기" 버튼 추가
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: Text(
                _isExpanded ? '접기' : '더보기',
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaylistItem extends StatelessWidget {
  final String title;
  final String duration;
  final String description;
  final VoidCallback onPlayPressed;

  PlaylistItem({
    required this.title,
    required this.duration,
    required this.description,
    required this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 (12px)
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            // 재생 시간 (11px, rgba(170, 170, 170, 1))
            Text(
              duration,
              style: TextStyle(fontSize: 11, color: Color.fromRGBO(170, 170, 170, 1)),
            ),
            // 설명 (12px, rgba(51, 51, 51, 0.6))
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Color.fromRGBO(51, 51, 51, 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
