import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifemaster_proj2/utils/modal_utils.dart';


class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
        toolbarHeight: 20, // AppBar 높이
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft, // 사용자 이미지를 왼쪽에 정렬
                  child: CircleAvatar(
                    radius: 35,
                    // backgroundImage: AssetImage('assets/user.png'), // 사용자 이미지
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('닉네임', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mypage_screen');
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
                      child: Text('마이페이지'),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Container(
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('전체서비스',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size(8, 8), // 버튼 최소 크기 설정
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          shape: RoundedRectangleBorder( // 둥근 모서리 없애기
                            borderRadius: BorderRadius.zero, // 모서리 반경 0
                          ),
                          backgroundColor: Colors.transparent, // 배경 투명
                          splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        ),
                        child: Text(
                          '편집',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8AB6BE)
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/alarm_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '알람',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/playlist');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/sleep_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '수면',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),

                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/challenge_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '챌린지',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/diary_screen');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/diary_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '자아성찰-일기',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/diary_screen');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/thank_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '자아성찰-5감사',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),

                  Divider(),

                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/group_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '그룹',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),

                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent, // 배경 투명
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/community_service.svg', // SVG 파일 경로
                            height: 24, // 원하는 크기 설정
                            width: 24, // 원하는 크기 설정
                          ),
                          SizedBox(width: 8),
                          Text(
                            '커뮤니티',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
            Divider(),

            Row(
              children: [
                Expanded(
                  flex: 1, // 1 비율
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/faq_screen');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                      backgroundColor: Color(0xFFF0F4F5), // 배경 색상
                      shadowColor: Colors.transparent, // 그림자 제거
                      splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 테두리 둥글기 없애기
                        side: BorderSide(color: Colors.transparent), // 테두리 투명
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: Color(0xFF131313),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '자주 묻는 질문',
                          style: TextStyle(
                            fontSize: 12,
                            color:  Color(0xFF131313),
                            fontWeight: FontWeight.w300,
                          ), // 글씨 크기
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1, // 비율
                  child: ElevatedButton(
                      onPressed: () {
                        showCustomerSupportModal(context);  // 고객 지원 모달 띄우기
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        backgroundColor: Color(0xFFF0F4F5), // 배경 색상
                        shadowColor: Colors.transparent, // 그림자 제거
                        splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 테두리 둥글기 없애기
                          side: BorderSide(color: Colors.transparent), // 테두리 투명
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Color(0xFF131313),
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '고객 지원',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF131313),
                              fontWeight: FontWeight.w300,
                            ), // 글씨 크기
                          )
                        ],
                      )
                  ),

                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showTermsOfServiceModal(context);  // 이용 약관 모달 띄우기
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                  ),
                  child: const Text(
                    '이용약관',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0x99131313),
                      fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showGamePrivacyPolicyModal(context);  // 게임 정보 처리 방침 모달 띄우기
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                  ),
                  child: const Text(
                    '개인정보처리방침',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0x99131313),
                      fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showRefundCancellationPolicyModal(context);  // 환불 및 취소 정책 모달 띄우기
                  },
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory, // 클릭 시 효과 없애기
                  ),
                  child: const Text(
                    '환불 및 취소정책',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0x99131313),
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
