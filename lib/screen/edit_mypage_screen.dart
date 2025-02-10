import 'package:flutter/material.dart';

class EditMyPageScreen extends StatefulWidget {
  @override
  _EditMyPageScreenState createState() => _EditMyPageScreenState();
}

class _EditMyPageScreenState extends State<EditMyPageScreen> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지 수정'),
        actions: [
          TextButton(
            onPressed: () {
              // 닉네임과 이메일을 저장하는 로직 추가 가능
              Navigator.pop(context); // 저장 후 이전 화면으로 돌아가기
            },
            child: Text(
              '저장',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('닉네임'),
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                hintText: '새 닉네임을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('이메일 주소'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: '새 이메일을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
