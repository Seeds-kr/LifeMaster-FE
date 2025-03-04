import 'dart:ui';
import 'package:flutter/material.dart';


class EditMyPageScreen extends StatefulWidget {
  @override
  _EditMyPageScreenState createState() => _EditMyPageScreenState();
}

class _EditMyPageScreenState extends State<EditMyPageScreen> {
  String? selectedPlan; // 현재 선택된 구독 정보

  // 선택된 구독 정보를 바탕으로 색상 변경
  Color getBorderColor(String plan) {
    return selectedPlan == plan ? Color(0xFF7CD7BD) : Colors.transparent; // 테두리 색상만 변경
  }

  Color getTextColor(String plan) {
    return selectedPlan == plan ? Color(0xFF7CD7BD) : Color(0x99131313); // 선택된 버튼 아래 텍스트 색상 변경
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        title: Text(
          '정보수정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF131313),
          ),
        ),
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
                    color: Color(0x99131313),
                  ),
                ),
                Container(
                  width: 280,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F4F5), // 배경 색상
                    borderRadius: BorderRadius.circular(8), // radius 적용
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // 기본 테두리 제거
                      hintText: '사용자 닉네임',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF131313),
                      ),
                    ),
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
                    color: Color(0x99131313),
                  ),
                ),
                Container(
                  width: 280,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F4F5), // 배경 색상
                    borderRadius: BorderRadius.circular(8), // radius 적용
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // 기본 테두리 제거
                      hintText: '사용자 이메일 주소',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // 구독정보
            Text(
              '구독 정보',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF131313),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '변경하신 구독 정보는 다음 구독일부터 적용됩니다',
              style: TextStyle(
                fontSize: 12,
                color: Color(0x99131313),
              ),
            ),
            SizedBox(height: 20),

            // 구독 플랜 선택 (Basic, Pro, Ultra) - Row로 배치
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // 높이를 위에서부터 시작
              children: [
                Flexible(
                  flex: 1,  // 첫 번째 구독 플랜
                  child: buildSubscriptionOption('Basic', '월₩1,000', '- 알람  \n - 알람1 \n - 알람2 '),
                ),
                SizedBox(width: 16), // 버튼들 간의 간격
                Flexible(
                  flex: 1,  // 두 번째 구독 플랜
                  child: buildSubscriptionOption('Pro', '월₩2,000', '- 첼린지 제외 \n 모든 기능 \n'),
                ),
                SizedBox(width: 16), // 버튼들 간의 간격
                Flexible(
                  flex: 1,  // 세 번째 구독 플랜
                  child: buildSubscriptionOption('Ultra', '월₩3,000', '- 모든 기능 \n \n'),
                ),
              ],
            ),
            // 화면 하단에 고정된 취소 및 저장 버튼들
            Spacer(), // 나머지 공간을 채워서 버튼이 하단에 고정되도록 함
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
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
                                      '정보 수정을 그만 둘까요?',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF131313),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      '변경된 내용은 저장되지 않아요.',
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
                                              Navigator.of(context).pop();
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
                                              '취소하기',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF131313),
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/mypage_screen');
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
                                              '그만두기',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
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
                      );                    },
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
                      '취소하기',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
                      '저장하기',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
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
    );
  }

  // 구독 옵션을 위한 위젯
  Widget buildSubscriptionOption(String plan, String price, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 가운데 정렬
      mainAxisAlignment: MainAxisAlignment.start, // 높이는 위쪽에서 시작
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPlan = plan; // 사용자가 선택한 구독 플랜을 저장
            });
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFFF0F4F5), // 기본 배경색
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: getBorderColor(plan), // 선택된 버튼의 테두리 색상만 변경
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            // 버튼 안에 아무 것도 넣지 않음
          ),
        ),
        SizedBox(height: 8), // 텍스트와 버튼 사이 간격
        Text(
          plan,  // 선택된 구독 플랜의 텍스트
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold, // 텍스트 굵게 수정
            color: getTextColor(plan), // 선택된 플랜에 따라 텍스트 색상 변경
          ),
          textAlign: TextAlign.center, // 텍스트를 가운데 정렬
        ),
        SizedBox(height: 4), // 설명과 텍스트 사이 간격
        Text(
          price,
          style: TextStyle(
            fontSize: 12,
            color: Color(0x99131313), // 설명 텍스트 색상
          ),
          textAlign: TextAlign.center, // 설명도 가운데 정렬
        ),
        SizedBox(height: 4), // 설명과 텍스트 사이 간격
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Color(0x99131313), // 설명 텍스트 색상
          ),
          textAlign: TextAlign.center, // 설명도 가운데 정렬
        ),
      ],
    );
  }
}
