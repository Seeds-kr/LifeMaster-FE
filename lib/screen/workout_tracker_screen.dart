import 'package:flutter/material.dart';
// import 'package:seeds_proj/screen/memory_game_screen.dart';
import 'dart:ui';
import '../components/bottom_navigation.dart';
import 'challenge_detail_screen.dart';

class WorkoutTrackerScreen extends StatefulWidget {
  @override
  _WorkoutTrackerScreenState createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  String _selectedSort = '최신순';
  bool _isDropdownOpen = false;
  List<String> _sortOptions = ['최신순', '오래된 순', '인기순'];
  int _selectedIndex = 0;

  // 챌린지 데이터 리스트 추가
  final List<Map<String, String>> challenges = [
      {
      'title': '찬물 샤워 챌린지',
      'participants': '164명 참여 중',
      'description': '여러분, 상쾌한 아침을 시작할 준비가 되셨나요?\n이제 건강과 활력을 동시에 챙길 수 있는 찬물 샤워...',
      'date': '2024.06.10 ~',
      'image': 'assets/images/shower.png',
      'buttonText': '참여중',
    },
    {
    'title': '하루에 20분 스트레칭',
    'participants': '1,721명 참여 중',
    'description': '바쁜 일상 속에서 몸과 마음을 풀어줄 시간이 필요하지 않으신가요?\n지금 바로 하루 20분 스트레칭 챌린지에...',
    'date': '2024.05.19 ~',
    'image': 'assets/images/stretching.jpg',
    'buttonText': '참여하기',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '챌린지',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                      ),
                    ],
                  ),
                ),

                // Time circles
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildTimeCircle('9:12am', 'assets/images/shower.png'),
                      SizedBox(width: 12),
                      _buildTimeCircle('9:12am', 'assets/images/stretching.jpg'),
                      SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/workout_icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                '챌린지 이름으로 검색',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDropdownOpen = !_isDropdownOpen;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Text(
                                _selectedSort,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Challenge list
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(), // 내부 ListView의 스크롤을 비활성화
                      shrinkWrap: true, // 리스트의 크기를 내부적으로 조정
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: challenges.length,  // 챌린지 리스트의 길이만큼 표시
                      itemBuilder: (context, index) {
                        final challenge = challenges[index];  // 현재 인덱스의 챌린지 데이터
                        return _buildChallengeCard(
                          title: challenge['title']!,
                          participants: challenge['participants']!,
                          description: challenge['description']!,
                          date: challenge['date']!,
                          image: challenge['image']!,
                          buttonText: challenge['buttonText']!,
                        );
                      },
                    ),
                  ),
                ),
                BottomNavigation(
                  selectedIndex: _selectedIndex,
                  onItemTapped: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    // if (index == 1) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     // MaterialPageRoute(builder: (context) => MemoryGameScreen()),
                    //   );
                    }
                  // },
                ),
              ],
            ),
            if (_isDropdownOpen)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.23,
                right: 16,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: _sortOptions.map((String option) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSort = option;
                            _isDropdownOpen = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 14,
                              color: _selectedSort == option ? Colors.blue : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCircle(String time, String imageAsset) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent, // 배경색을 투명하게 설정합니다.
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 흐리게 할 이미지
          ClipOval(
            child: Image.asset(
              imageAsset,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              // 이미지의 흐림 효과를 주는 부분
              color: Colors.black.withOpacity(0.1), // 흐림 효과를 위해 이미지에 덮어쓸 색을 설정합니다.
              colorBlendMode: BlendMode.multiply, // 색을 덮어쓰는 방식을 설정합니다.
            ),
          ),
          // 흐림 효과
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 흐림 정도를 조절합니다.
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          // 내용 표시 (시간 및 아이콘)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // 글자 색상을 검정색으로 설정하여 뚜렷하게 합니다.
                    fontWeight: FontWeight.bold, // 글자 두께를 Bold로 설정하여 더욱 뚜렷하게 합니다.
                  ),
                ),
                Icon(Icons.check, size: 16, color: Colors.white), // 아이콘 색상도 검정색으로 설정합니다.
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildChallengeCard({
    required String title,
    required String participants,
    required String description,
    required String date,
    required String image,
    required String buttonText,
  }) {
    return GestureDetector(
      onTap: () {
        // 상세 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeDetailScreen(
              title: title,
              image: image,
              date: date,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    participants,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: buttonText == '참여중' ? Colors.blue : Colors.white,
                          width: 1.0
                        ),
                        foregroundColor: buttonText == '참여중' ? Colors.blue : Colors.white,
                        backgroundColor: buttonText == '참여중' ? Colors.white : Colors.blue[300],
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}