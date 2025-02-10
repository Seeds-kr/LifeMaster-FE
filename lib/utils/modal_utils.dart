import 'package:flutter/material.dart';
// import 'dart:ui';

void showCustomerSupportModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 320, // 너비 320
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '고객 지원',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131313),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.close,
                        color: Color(0xFF131313),
                        size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '고객님의 문의사항에 대한 답변을 이곳에서 확인하실 수 있습니다.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99131313),
                  fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                ),
              ),
              SizedBox(height: 12),
            ],
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
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 320, // 너비 320
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이용 약관',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131313),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF131313),
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '이용 약관에 대한 설명을 이곳에서 확인하실 수 있습니다.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99131313),
                  fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                ),
              ),
              SizedBox(height: 12),
            ],
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
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 320, // 너비 320
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '게임 정보 처리 방침',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131313),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF131313),
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '게임의 개인정보 처리 방침을 이곳에서 확인하실 수 있습니다.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99131313),
                  fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                ),
              ),
              SizedBox(height: 12),
            ],
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
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 320, // 너비 320
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '환불 및 취소 정책',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF131313),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF131313),
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '환불 및 취소 정책에 대해 자세히 알아보세요.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99131313),
                  fontWeight: FontWeight.w300, // 글씨 굵기를 얇게 설정
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}
