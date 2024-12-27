import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // 임의의 사용자 ID 리스트 (사용 불가능한 닉네임 예시)
  final List<String> unavailableNicknames = ['user123', 'test_user', 'flutter_dev'];
  late final String currentUserId;
  XFile? _selectedImage;
  TextEditingController _nicknameController = TextEditingController();
  String _nicknameStatus = ''; // 상태 메시지
  bool _isNicknameValid = false; // 닉네임 유효성 체크

  @override
  void initState() {
    super.initState();
    currentUserId = 'user123'; // 현재 사용자 ID
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // 닉네임이 사용 가능한지 확인하는 함수
  void _checkNicknameAvailability(String nickname) {
    setState(() {
      _isNicknameValid = !unavailableNicknames.contains(nickname) && nickname.isNotEmpty;
      _nicknameStatus = _isNicknameValid ? '사용 가능한 닉네임이에요' : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 첫 번째: 글을 쓸 수 있는 컨테이너
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 첫 번째: 손 이모지
                      Text(
                        '👋',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // 두 번째: 사용자 이름과 안내 텍스트
                      Text(
                        '안녕하세요',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black // 사용자 이름 색상
                        ),
                        textAlign: TextAlign.center,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$currentUserId',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF8AB6BE), // 사용자 이름 색상
                              ),
                            ),
                            const TextSpan(
                              text: '님',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black, // '님'은 검정색
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 세 번째: 안내 텍스트
                      Text(
                        '라이프마스터에 사용하실\n프로필의 이미와 닉네임을 등록해 주세요!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6), // 투명도 60%
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 두 번째: 회원 사진 추가 공간
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFF0F4F5),
                    backgroundImage:
                    _selectedImage != null ? FileImage(File(_selectedImage!.path)) : null,
                    child: _selectedImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 20, // 아이콘 크기 조정
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // 세 번째: 닉네임 입력 공간
                Container(
                  width: double.infinity, // 너비를 fill로 설정
                  height: 48, // 높이 설정
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4F5), // 색상 설정
                    borderRadius: BorderRadius.circular(8), // borderRadius 설정
                  ),
                  child: TextField(
                    controller: _nicknameController,
                    onChanged: (nickname) {
                      _checkNicknameAvailability(nickname); // 닉네임 입력 시 상태 확인
                    },
                    decoration: InputDecoration(
                      labelText: '닉네임',
                      labelStyle: TextStyle(
                        fontSize: 12, // 글자 크기 설정
                        color: const Color(0x99131313), // 투명도 60%로 설정
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none), // 테두리 없애기
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 네 번째: 닉네임 사용 가능 여부 텍스트와 체크 아이콘
                if (_nicknameStatus.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF8AB6BE),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _nicknameStatus,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8AB6BE),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // 네 번째: 버튼을 화면 아래에 배치
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _isNicknameValid ? () {
                  // 버튼 클릭 이벤트 처리
                } : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(361, 48),
                  backgroundColor: const Color(0xFFA0E0CF), // 배경 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // radius 설정
                  ),
                ),
                child: Text(
                  _isNicknameValid ? '라이프마스터 시작하기' : '닉네임을 입력해 주세요',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white, // 글자 색상
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
