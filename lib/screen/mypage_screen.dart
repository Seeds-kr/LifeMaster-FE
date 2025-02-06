import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        automaticallyImplyLeading: true, // 기본 뒤로 가기 버튼 활성화
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileSection(),
            SizedBox(height: 20),
            _buildSettingsSection(),
            SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // 프로필 섹션
  Widget _buildProfileSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_image.png'), // 사용자 이미지
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '사용자 이름', // 사용자 이름
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('user@example.com'), // 이메일
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 설정 섹션
  Widget _buildSettingsSection() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          _buildSettingItem('알림 설정', Icons.notifications),
          _buildSettingItem('개인 정보 보호', Icons.lock),
          _buildSettingItem('언어 설정', Icons.language),
        ],
      ),
    );
  }

  // 각 설정 항목
  Widget _buildSettingItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // 설정 항목을 클릭했을 때 원하는 행동 추가
        print('$title 클릭됨');
      },
    );
  }

  // 로그아웃 버튼
  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 로그아웃 기능 추가
        Navigator.pop(context); // 예시로 뒤로가기
      },
      child: Text('로그아웃'),
    );
  }
}
