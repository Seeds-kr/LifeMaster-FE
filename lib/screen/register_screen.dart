import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:lifemaster_proj2/screen/user_info_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _passwordError = ''; // 비밀번호 확인 오류 메시지
  String _newPasswordError = ''; // 새 비밀번호 오류 메시지

  final Dio _dio = Dio(); // Dio 인스턴스 생성

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // 비밀번호 확인
  void _checkPasswordMatch() {
    setState(() {
      if (_passwordController.text != _confirmPasswordController.text) {
        _passwordError = '비밀번호가 일치하지 않아요';
      } else {
        _passwordError = ''; // 일치하면 오류 메시지 제거
      }
    });
  }

  // 새 비밀번호 유효성 검사
  void _checkNewPasswordValidity() {
    setState(() {
      // 비밀번호가 대소문자, 숫자를 포함해 8~16자여야 한다는 조건 추가
      if (_passwordController.text.length < 8 || _passwordController.text.length > 16 ||
          !_passwordController.text.contains(RegExp(r'[A-Z]')) ||
          !_passwordController.text.contains(RegExp(r'[a-z]')) ||
          !_passwordController.text.contains(RegExp(r'[0-9]'))) {
        _newPasswordError = '비밀번호는 대소문자, 숫자를 포함해 8~16자여야 해요';
      } else {
        _newPasswordError = ''; // 유효한 비밀번호일 경우 오류 메시지 제거
      }
    });
  }

// 회원가입 처리
  void _register() async {
    if (_passwordController.text == _confirmPasswordController.text && _newPasswordError.isEmpty) {
      try {
        // 회원가입 요청을 보낼 데이터
        var data = {
          'email': _emailController.text,
          'password': _passwordController.text,
          'passwordConfirm': _confirmPasswordController.text, // 확인 비밀번호 추가
        };

        // Dio를 사용하여 POST 요청 보내기
        Response response = await _dio.post(
          'http://10.0.2.2:8080/user/register',
          data: data,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        // 요청 성공 시 처리
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('회원가입이 완료되었습니다.')),
          );

          // 회원가입이 완료되면 로그인 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserInfoScreen(email: _emailController.text)),
          );
        } else {
          // 서버에서 오류가 발생하면 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('오류: ${response.data['message']}')),
          );
        }
      } catch (e) {
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('서버와 연결할 수 없습니다.')),
        );
      }
    } else {
      setState(() {
        _passwordError = '비밀번호를 다시 설정해주세요';
      });
    }
  }

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
            const SizedBox(height: 80), // 이미지와 TextField 사이에 간격을 추가

            // 이메일 입력란
            Container(
              width: double.infinity, // 너비를 fill로 설정
              height: 48, // 높이 설정
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F5), // 색상 설정
                borderRadius: BorderRadius.circular(8), // borderRadius 설정
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일',
                  hintStyle: TextStyle(
                    fontSize: 12, // 글자 크기 설정
                    color: Color(0x99131313), // 투명도 60%로 설정
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none), // 테두리 없애기
                  contentPadding: EdgeInsets.only(left: 16), // 내부 여백 조정
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 비밀번호 입력란
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: true, // 비밀번호 입력 감추기
                onChanged: (value) {
                  _checkNewPasswordValidity(); // 새 비밀번호 유효성 검사
                },
                decoration: const InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0x99131313),
                  ),
                  contentPadding: EdgeInsets.only(left: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (_newPasswordError.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Text(
                  _newPasswordError,
                  style: const TextStyle(
                    color: Color(0xFFFF5151),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),

            // 비밀번호 확인 입력란
            Container(
              width: double.infinity, // 너비를 fill로 설정
              height: 48, // 높이 설정
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F5), // 배경 색상 설정
                borderRadius: BorderRadius.circular(8), // borderRadius 설정
              ),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true, // 비밀번호 입력 감추기
                onChanged: (value) {
                  _checkPasswordMatch(); // 비밀번호 확인 시 일치 여부 확인
                },
                decoration: const InputDecoration(
                  hintText: '비밀번호 확인',
                  hintStyle: TextStyle(
                    fontSize: 12, // 글자 크기 설정
                    color: Color(0x99131313), // 색상 및 투명도 설정
                  ),
                  contentPadding: EdgeInsets.only(left: 16), // 내부 여백 조정
                  border: InputBorder.none, // 테두리 없애기
                ),
              ),
            ),
            if (_passwordError.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Text(
                  _passwordError,
                  style: const TextStyle(
                    color: Color(0xFFFF5151),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),

            // 회원가입 버튼
            SizedBox(
              width: double.infinity, // 너비를 fill로 설정
              height: 48, // 높이 설정
              child: ElevatedButton(
                onPressed: _register, // 회원가입 처리
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CD7BD), // 버튼 배경색 (필요 시 수정)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게 설정
                  ),
                ),
                child: const Text(
                  '회원가입',
                  textAlign: TextAlign.center, // 글자 중앙 정렬
                  style: TextStyle(
                    color: Colors.white, // 글자 색상 흰색
                    fontSize: 12, // 글자 크기 12
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 이미 계정이 있으신가요? 텍스트와 로그인 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '이미 계정이 있으신가요?',
                  style: TextStyle(
                    color: Color(0x66000000), // 40% 투명도 적용된 검정색
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/email_login'); // 로그인 페이지로 이동
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: const Color(0xFF8AB6BE), // 버튼 텍스트 색상
                      fontSize: 12,
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
