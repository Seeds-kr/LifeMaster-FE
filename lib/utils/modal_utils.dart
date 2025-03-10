import 'package:flutter/material.dart';
import 'dart:ui';

void showCustomerSupportModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모달창 둥글게
          ),
          backgroundColor: Colors.white, // 모달창 배경 흰색
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '고객지원',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '고객지원에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x99131313),
                  ),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFF0F4F5), // 닫기 버튼 색상
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showTermsOfServiceModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모달창 둥글게
          ),
          backgroundColor: Colors.white, // 모달창 배경 흰색
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이용약관',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '이용약관에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x99131313),
                  ),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFF0F4F5), // 닫기 버튼 색상
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showGamePrivacyPolicyModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모달창 둥글게
          ),
          backgroundColor: Colors.white, // 모달창 배경 흰색
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '개인정보처리방침',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '개인정보처리방침에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x99131313),
                  ),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFF0F4F5), // 닫기 버튼 색상
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showRefundCancellationPolicyModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모달창 둥글게
          ),
          backgroundColor: Colors.white, // 모달창 배경 흰색
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '환불 및 취소정책',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '환불 및 취소정책에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x99131313),
                  ),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFF0F4F5), // 닫기 버튼 색상
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSubscriptionDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // 블러 효과
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 모달창 둥글게
          ),
          backgroundColor: Colors.white, // 모달창 배경 흰색
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '요금제 정보',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '요금제 정보에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0x99131313),
                  ),
                  textAlign: TextAlign.left, // 왼쪽 정렬
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFF0F4F5), // 닫기 버튼 색상
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF131313),
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


//showCancelConfirmationDialog