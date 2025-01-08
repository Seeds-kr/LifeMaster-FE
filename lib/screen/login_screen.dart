import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // 애니메이션이 반복되도록 설정

    // 애니메이션: 위아래로 움직이도록 설정 (둥둥 떠다니는 효과)
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.01), // 시작 위치 (위쪽)
      end: Offset(0.0, 0.01),    // 끝 위치 (아래쪽)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,  // 부드러운 애니메이션 효과
    ));
  }

  @override
  void dispose() {
    _controller.dispose(); // 애니메이션 컨트롤러 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isEmailVerified
            ? IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0, // 아이콘 크기 설정
          ),
          onPressed: () {
              Navigator.pop(context); // 이전 화면으로 돌아가기
          },
        )
            : IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0, // 아이콘 크기 설정
          ), // 왼쪽에 "뒤로 가기" 화살표 아이콘 추가
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 자식들을 수직 중앙에 배치
          children: [
            SlideTransition(
              position: _offsetAnimation, // 위아래로 움직이는 애니메이션 적용
              child: SvgPicture.asset(
                'assets/images/background_image.svg', // SVG 이미지 경로
                height: 282, // 이미지 크기 조정
                width: 402,
              ),
            ),
            const SizedBox(height: 80), // 이미지와 버튼 사이에 간격을 추가
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼을 균등 배치
              children: [
                IconButton(
                  onPressed: () {
                    // 네이버 로그인 로직 추가
                  },
                  icon: SvgPicture.asset(
                    'assets/images/naver.svg', // 네이버 버튼 이미지
                    height: 42,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // 구글 로그인 로직 추가
                  },
                  icon: SvgPicture.asset(
                    'assets/images/google.svg', // 구글 버튼 이미지
                    height: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // 카카오 로그인 로직 추가
                  },
                  icon: SvgPicture.asset(
                    'assets/images/kakao.svg', // 카카오 버튼 이미지
                    height: 42,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // 버튼 간격 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/email_login');
                  },
                  child: const Text(
                    '이메일로 로그인',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                    ),
                  ),
                ),
                const Text(
                  '|',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    '이메일로 회원가입',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
