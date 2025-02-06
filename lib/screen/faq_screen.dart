import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // 각 질문이 펼쳐졌는지 아닌지를 관리하기 위한 상태
  final List<bool> _expanded = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '자주 묻는 질문',
          style: TextStyle(
            fontSize: 20, // 텍스트 크기 24
            fontWeight: FontWeight.bold, // 볼드체
          ),
        ),
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        toolbarHeight: 80, // AppBar 높이
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent, // 모든 ExpansionTile의 divider 색상 없애기
          ),
          child: ListView(
            padding: EdgeInsets.zero, // ListView의 기본 패딩을 없애기
            children: [
              _buildFaqItem('[카테고리]', '질문 1', '답변 1: 여기에 답변 내용이 들어갑니다.', 0),
              _buildFaqItem('[카테고리]', '질문 2', '답변 2: 여기에 답변 내용이 들어갑니다.', 1),
              _buildFaqItem('[카테고리]', '질문 3', '답변 3: 여기에 답변 내용이 들어갑니다.', 2),
              _buildFaqItem('[카테고리]', '질문 4', '답변 4: 여기에 답변 내용이 들어갑니다.', 3),
              _buildFaqItem('[카테고리]', '질문 5', '답변 5: 여기에 답변 내용이 들어갑니다.', 4),
              // 추가적인 FAQ 항목들
            ],
          ),
        ),
      ),
    );
  }

  // FAQ 항목을 구성하는 위젯
  Widget _buildFaqItem(String category, String question, String answer, int index) {
    return Material(
      type: MaterialType.transparency, // Material을 투명하게 설정
      child: Card(
        margin: EdgeInsets.zero, // 카드 간격 없애기
        elevation: 0, // 카드의 그림자 제거
        color: Colors.transparent, // 배경을 투명하게 설정
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // 선 없애기
        child: GestureDetector( // GestureDetector로 클릭 이벤트 처리
          onTap: () {}, // 클릭 이벤트가 필요할 경우 빈 처리
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero, // ExpansionTile 안의 패딩을 없애기
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 카테고리와 질문을 양 끝에 배치
              children: [
                Text(
                  category,
                  style: TextStyle(fontSize: 14, color: Color(0xFF8AB6BE)), // 카테고리 스타일
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: _expanded[index] ? FontWeight.bold : FontWeight.normal, // 펼쳐지면 bold 처리
                    ),
                    overflow: TextOverflow.ellipsis, // 질문이 길면 생략 표시
                  ),
                ),
              ],
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _expanded[index] = expanded; // 해당 인덱스의 펼쳐짐 상태를 갱신
              });
            },
            children: [
              Container(
                width: double.infinity, // 너비를 전체 화면 크기에 맞게 설정
                decoration: BoxDecoration(
                  color: Color(0xFFF0F4F5), // 답변 배경색
                  borderRadius: BorderRadius.circular(8), // 라운드된 테두리
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 14, // 글씨 크기
                      color: Color(0xFF131313), // 글씨 색상
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
