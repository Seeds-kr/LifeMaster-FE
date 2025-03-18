import 'package:flutter/material.dart';

class SleepReportScreen extends StatefulWidget {
  @override
  _SleepReportScreenState createState() => _SleepReportScreenState();
}

class _SleepReportScreenState extends State<SleepReportScreen> {
  final List<IconData> moodIcons = [
    Icons.sentiment_very_dissatisfied_outlined,
    Icons.sentiment_dissatisfied_outlined,
    Icons.sentiment_satisfied_alt,
    Icons.sentiment_very_satisfied_outlined,
  ];

  int? selectedMoodIndex;
  int sleepHours = 7;
  int sleepMinutes = 30;

  Map<String, dynamic>? selectedDayData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "오늘은 \n총 $sleepHours시간 $sleepMinutes분 잤어요",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            _buildMoodSelection(),
            const SizedBox(height: 16),
            // 그래프 관련 부분
            _buildGraphContainer(),
            const SizedBox(height: 16),
            _buildBelowContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0x4DBBAB94),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            " 오늘의 기분",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFBBAB94)),
          ),
          Row(
            children: List.generate(moodIcons.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMoodIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    moodIcons[index],
                    size: 40,
                    color: selectedMoodIndex == index ? const Color(0xFF927448) : const Color(0x1A131313),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphContainer() {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildBelowContainer() {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 텍스트 부분
          const Text(
            "평소보다",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF131313),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // 2x2로 박스 배치하기 (Row, Column 활용)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 70,  // 높이를 70으로 설정
                  decoration: BoxDecoration(
                    color: Color(0x4DBBAB94),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // '더 잤어요' 텍스트
                      const Text(
                        "더 잤어요",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF131313),
                        ),
                      ),
                      const SizedBox(height: 4), // 텍스트 사이 간격
                      // Row로 'n분' 텍스트와 함께
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 'n분' 텍스트
                          const Text(
                            "n분",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF131313),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8), // 텍스트 사이 간격
                          // '11'을 감싼 Container
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFBBAB94),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,  // Row의 크기를 자식 위젯에 맞게 조정
                              children: [
                                // '11' 텍스트
                                const Text(
                                  "11",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4), // 텍스트와 아이콘 사이 간격
                                // 업다운 아이콘 (예: ^ 기호)
                                const Icon(
                                  Icons.arrow_upward,  // 위로 향하는 화살표 아이콘
                                  size: 14,  // 아이콘 크기
                                  color: Colors.white,  // 아이콘 색상
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 두 번째 박스 (BBAB94 색상)
              Expanded(
                child: Container(
                  height: 70,  // 높이를 70으로 설정
                  decoration: BoxDecoration(
                    color: Color(0x4D7CD7BD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // '더 잤어요' 텍스트
                      const Text(
                        "수면점수",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF131313),
                        ),
                      ),
                      const SizedBox(height: 4), // 텍스트 사이 간격
                      // Row로 'n분' 텍스트와 함께
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 'n분' 텍스트
                          const Text(
                            "n점",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF131313),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8), // 텍스트 사이 간격
                          // '11'을 감싼 Container
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF7CD7BD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,  // Row의 크기를 자식 위젯에 맞게 조정
                              children: [
                                // '11' 텍스트
                                const Text(
                                  "11",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4), // 텍스트와 아이콘 사이 간격
                                // 업다운 아이콘 (예: ^ 기호)
                                const Icon(
                                  Icons.arrow_upward,  // 위로 향하는 화살표 아이콘
                                  size: 14,  // 아이콘 크기
                                  color: Colors.white,  // 아이콘 색상
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 세 번째 박스 (7CD7BD 색상)
              Expanded(
                child: Container(
                  height: 70,  // 높이를 70으로 설정
                  decoration: BoxDecoration(
                    color: Color(0x4DBBAB94),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // '더 잤어요' 텍스트
                      const Text(
                        "알람이 울린 시간",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF131313),
                        ),
                      ),
                      const SizedBox(height: 4), // 텍스트 사이 간격
                      const Text(
                        "n",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF131313),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 네 번째 박스 (7CD7BD 색상)
              Expanded(
                child: Container(
                  height: 70,  // 높이를 70으로 설정
                  decoration: BoxDecoration(
                    color: Color(0x4D7CD7BD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // '더 잤어요' 텍스트
                      const Text(
                        "일어나는 데 걸린 시간",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF131313),
                        ),
                      ),
                      const SizedBox(height: 4), // 텍스트 사이 간격
                      // Row로 'n분' 텍스트와 함께
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 'n분' 텍스트
                          const Text(
                            "n분",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF131313),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8), // 텍스트 사이 간격
                          // '11'을 감싼 Container
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF7CD7BD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,  // Row의 크기를 자식 위젯에 맞게 조정
                              children: [
                                // '11' 텍스트
                                const Text(
                                  "11",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4), // 텍스트와 아이콘 사이 간격
                                // 업다운 아이콘 (예: ^ 기호)
                                const Icon(
                                  Icons.arrow_upward,  // 위로 향하는 화살표 아이콘
                                  size: 14,  // 아이콘 크기
                                  color: Colors.white,  // 아이콘 색상
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
