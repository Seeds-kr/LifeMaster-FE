import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:lifemaster_proj2/screen/user_info_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio _dio = Dio();
  // bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // 애니메이션 반복 설정

    // 위아래로 움직이는 애니메이션 설정
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.01), // 시작 위치
      end: const Offset(0.0, 0.01),    // 끝 위치
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 부드러운 애니메이션 효과
    ));
  }

  @override
  void dispose() {
    _controller.dispose(); // 애니메이션 컨트롤러 종료
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('이메일과 비밀번호를 입력해주세요.');
      return;
    }

    try {
      // 백엔드 로그인 API 호출
      final response = await _dio.post(
        'http://10.0.2.2:8080/user/login', // 실제 API 엔드포인트로 수정
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final String email = _emailController.text.trim(); //임의로 추가

        // 로그인 성공 처리
        final token = response.data.toString(); // 서버에서 반환된 JWT 토큰
        _showMessage('로그인 성공');
        Navigator.pushNamed(context, '/home'); // 홈 화면으로 이동
        // 로그인 성공 후 사용자 정보 확인 (예: 토큰 저장)
        // SharedPreferences나 다른 방법으로 토큰을 저장할 수 있습니다.
        // 예: SharedPreferences를 사용하여 토큰 저장

        // await _saveToken(token);

      } else {
        _showMessage('로그인 실패: ${response.data}');
      }
    } catch (e) {
      _showMessage('오류 발생: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    // SharedPreferences나 SecureStorage를 이용하여 토큰 저장
    // 예: SharedPreferences 사용
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24.0, // 아이콘 크기
          ),
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
              position: _offsetAnimation, // 애니메이션 적용
              child: SvgPicture.asset(
                'assets/images/background_image.svg', // SVG 이미지 경로
                height: 282, // 이미지 높이
                width: 402,  // 이미지 너비
              ),
            ),
            const SizedBox(height: 80), // 간격 추가
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0x99131313),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.only(left: 16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: true, // 비밀번호 입력 가리기
                decoration: const InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0x99131313),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.only(left: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CD7BD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/password_reset');
                  },
                  child: const Text(
                    '비밀번호 찾기',
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
                    '회원가입',
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
