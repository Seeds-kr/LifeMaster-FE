import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lifemaster_proj2/utils/modal_utils.dart';


class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        title: Text(
            '마이페이지',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF131313)
            )
        ),
        actions: [
          TextButton(
            onPressed: () {
                Navigator.pushNamed(context, '/edit_mypage_screen');
            },
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
            ),
            child: Text(
                '수정',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF131313)
                ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 회원 이미지
            Center(
              child: CircleAvatar(
                radius: 60,
                // backgroundImage: AssetImage('assets/images/member_image.png'), // 사용자 이미지
              ),
            ),
            SizedBox(height: 32),

            // 닉네임
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '닉네임',
                    style: TextStyle(
                      fontSize: 14,
                        color: Color(0x99131313)
                    )
                ),
                Text(
                    '사용자 닉네임',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF131313)
                    ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // 이메일 주소
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '이메일 주소',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0x99131313)
                    )
                ),
                Text(
                  '사용자 이메일 주소',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131313)
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),


            // 구독정보
            Text('구독정보',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313)
                )
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0F4F5), // 회색 박스
                        borderRadius: BorderRadius.circular(10), // 둥근 모서리
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rro',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF131313)
                            ),
                        ),
                        Text(
                            '텍스트 2',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0x77131313)
                            )
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    showSubscriptionDetails(context); //요금제 정보
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF8AB6BE), // 글씨 색상 (8AB6BE)
                    textStyle: TextStyle(fontSize: 12), // 글씨 크기 12
                    backgroundColor: Color(0x4D7CD7BD), // 배경 색상 (30% opacity)
                    shadowColor: Colors.transparent, // 그림자 제거
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 테두리 반경 8
                    ),
                    side: BorderSide(
                      color: Color(0xFF7CD7BD), // 테두리 색상 (100% opacity)
                      width: 1, // 테두리 두께
                    ),
                    elevation: 0,
                    minimumSize: Size(80, 30), // 버튼 최소 크기 설정
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2), // 버튼 안쪽 여백 줄이기
                  ),
                  child: Text('요금제 정보'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),

            // 결제내역
            Text('결제내역', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 16),

            // 회원 탈퇴 버튼
            Center(
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // 모달 둥글게
                          ),
                          backgroundColor: Colors.white, // 모달 배경 흰색
                          child: Container(
                            width: 320,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '회원 탈퇴',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF131313),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '정말로 마이라이프를 떠나시겠어요?\n이 작업은 되돌릴 수 없어요',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0x99131313),
                                  ),
                                  textAlign: TextAlign.left, // 왼쪽 정렬
                                ),
                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // 취소 버튼
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(double.infinity, 48),
                                          backgroundColor: Color(0xFF7CD7BD), // 취소 버튼 배경색
                                          shadowColor: Colors.transparent, // 그림자 제거
                                          splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: Colors.transparent),
                                          ),
                                        ),
                                        child: Text(
                                          '취소하기',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // 탈퇴 로직 추가
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(double.infinity, 48),
                                          backgroundColor: Color(0xFFF0F4F5), // 탈퇴 버튼 배경색
                                          shadowColor: Colors.transparent, // 그림자 제거
                                          splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: Colors.transparent),
                                          ),
                                        ),
                                        child: Text(
                                          '탈퇴하기',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF131313),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                ),
                child: const Text(
                  '회원 탈퇴',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0x99131313),
                    fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
