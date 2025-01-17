import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> with SingleTickerProviderStateMixin {
  final Dio _dio = Dio();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool isEmailVerified = false; // 이메일 인증 여부
  String _passwordError = ''; // 비밀번호 확인 오류 메시지
  String _newPasswordError = ''; // 새 비밀번호 오류 메시지

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

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
      begin: Offset(0.0, -0.05), // 시작 위치 (위쪽)
      end: Offset(0.0, 0.05),    // 끝 위치 (아래쪽)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,  // 부드러운 애니메이션 효과
    ));
  }

  // 이메일 인증 버튼 클릭 시
  void _sendVerificationEmail(String email) async {
    final url = 'http://10.0.2.2:8080/api/auth/send-email';

    try {
      // 서버에 이메일 존재 여부 확인 요청
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
        ),
        data: email, // 이메일 데이터를 JSON으로 전송
      );

      // 서버 응답 처리
      if (response.statusCode == 200) {
        // 이메일이 유효하면 인증 메일 발송 성공 처리
        setState(() {
          isEmailVerified = true;
        });
        _showMessage('인증 메일이 발송되었습니다.');
      } else {
        // 200 이외의 상태 코드 처리
        final message = response.data['message'] ?? '알 수 없는 오류가 발생했습니다.';
        _showMessage(message);
      }
    } on DioError catch (e) {
      // 서버 오류 또는 네트워크 오류 처리
      if (e.response != null) {
        final message = e.response?.data['message'] ?? '서버에서 처리할 수 없습니다.';
        _showMessage(message);
      } else {
        _showMessage('네트워크 오류가 발생했습니다. 다시 시도해주세요.');
      }
    }
  }

  // 이메일 메시지
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // 표시 시간
      ),
    );
  }

  // 비밀번호 확인
  void _checkPasswordMatch() {
    setState(() {
      if (_newPasswordController.text != _confirmPasswordController.text) {
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
      if (_newPasswordController.text.length < 8 || _newPasswordController.text.length > 16 ||
          !_newPasswordController.text.contains(RegExp(r'[A-Z]')) ||
          !_newPasswordController.text.contains(RegExp(r'[a-z]')) ||
          !_newPasswordController.text.contains(RegExp(r'[0-9]'))) {
        _newPasswordError = '비밀번호는 대소문자, 숫자를 포함해 8~16자여야 해요';
      } else {
        _newPasswordError = ''; // 유효한 비밀번호일 경우 오류 메시지 제거
      }
    });
  }

  // 비밀번호 변경 처리
  Future<void> _resetPassword(BuildContext context, String token) async {
    // 비밀번호 검증
    _checkPasswordMatch();
    _checkNewPasswordValidity();

    if (_newPasswordError.isEmpty && _passwordError.isEmpty) {
      try {
        final dio = Dio();
        final response = await dio.post(
          'http://10.0.2.2:8080/api/auth/reset-password',
          data: {
            "token": token,
            "newPassword": _newPasswordController.text,
            "checkPassword": _confirmPasswordController.text,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
          );
        }
      } on DioError catch (e) {
        String errorMessage = '알 수 없는 오류가 발생했어요.';
        if (e.response?.statusCode == 401) {
          errorMessage = '유효하지 않은 토큰입니다.';
        } else if (e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      // 비밀번호 검증 실패 시 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호를 다시 확인해주세요.')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // 애니메이션 컨트롤러 종료
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isEmailVerified
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios,
          size: 24.0, // 아이콘 크기 설정
          ),
          onPressed: () {
            setState(() {
              isEmailVerified = false; // 이메일 인증 전 상태로 변경
            });
          },
        )
            :IconButton(
          icon: const Icon(Icons.arrow_back_ios,
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
            const SizedBox(height: 80), // 이미지와 TextField 사이에 간격을 추가

            // 인증 전: 이메일 입력란 및 인증 메일 받기 버튼
            if (!isEmailVerified) ...[
              const Text(
                '비밀번호 찾기', // 추가할 텍스트
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF131313),
                ),
              ),
              const SizedBox(height: 8), // 이미지와 TextField 사이에 간격을 추가
              const Text(
                '가입했던 이메일로 인증해 주세요',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99131313),
                ),
              ),
              const SizedBox(height: 80), // 이미지와 TextField 사이에 간격을 추가
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

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity, // 너비를 fill로 설정
                height: 48, // 높이 설정
                child: ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      _showMessage('이메일을 입력해주세요.');
                      return;
                    }
                    _sendVerificationEmail(email); // 입력한 이메일로 요청
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7CD7BD), // 버튼 배경색 (필요 시 수정)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게 설정
                    ),
                  ),
                  child: const Text(
                    '인증 메일 받기',
                    textAlign: TextAlign.center, // 글자 중앙 정렬
                    style: TextStyle(
                      color: Colors.white, // 글자 색상 흰색
                      fontSize: 12, // 글자 크기 12
                    ),
                  ),
                ),
              ),
            ],
            // 인증 후: 이메일 인증 완료 및 비밀번호 입력란
            if (isEmailVerified) ...[
              Container(
                width: double.infinity, // 너비를 fill로 설정
                padding: const EdgeInsets.symmetric(vertical: 8), // 높이를 hug로 설정 (텍스트에 맞게)
                decoration: BoxDecoration(
                  color: const Color(0x4D7CD7BD), // 배경 색상 (7CD7BD, 투명도 30%)
                  borderRadius: BorderRadius.circular(8), // radius 설정
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 아이콘과 텍스트를 중앙 정렬
                  children: [
                    Icon(
                      Icons.check_circle, // 체크모양 아이콘
                      color: Color(0xFF8AB6BE), // 아이콘 색상
                      size: 16, // 아이콘 크기
                    ),
                    SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                    Text(
                      '이메일 인증 완료',
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                      style: TextStyle(
                        fontSize: 12, // 글자 크기
                        color: Color(0xFF8AB6BE), // 글자 색상
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 새로운 비밀번호 입력란
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _newPasswordController,
                  obscureText: true, // 비밀번호 입력 감추기
                  onChanged: (value) {
                    _checkNewPasswordValidity(); // 새 비밀번호 유효성 검사
                  },
                  decoration: const InputDecoration(
                    hintText: '새로운 비밀번호',
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
                )
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

              SizedBox(
                width: double.infinity, // 너비를 fill로 설정
                height: 48, // 높이 설정
                child: ElevatedButton(
                  onPressed: () => _resetPassword(context, 'your_token_here'), // 비밀번호 변경 처리
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7CD7BD), // 버튼 배경색 (필요 시 수정)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게 설정
                    ),
                  ),
                  child: const Text(
                    '비밀번호 변경',
                    textAlign: TextAlign.center, // 글자 중앙 정렬
                    style: TextStyle(
                      color: Colors.white, // 글자 색상 흰색
                      fontSize: 12, // 글자 크기 12
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
