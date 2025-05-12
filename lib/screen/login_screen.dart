// import 'package:flutter/material.dart';
//
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("로그인"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Spacer(),
//             Text(
//               '캐치프레이즈 한 문장\n두 줄로 작성',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Spacer(),
//             Column(
//               children: [
//                 _buildSocialLoginButton(
//                   color: Colors.green,
//                   icon: Icons.language, // 네이버 아이콘 대체
//                   text: '네이버로 시작하기',
//                   onPressed: () async {
//                     await _handleNaverLogin(context);
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 _buildSocialLoginButton(
//                   color: Colors.white,
//                   icon: Icons.g_mobiledata, // 구글 아이콘 대체
//                   text: '구글로 시작하기',
//                   textColor: Colors.black,
//                   onPressed: () {
//                     // 구글 로그인 로직 추가
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 _buildSocialLoginButton(
//                   color: Colors.yellow,
//                   icon: Icons.chat, // 카카오톡 아이콘 대체
//                   text: '카카오로 시작하기',
//                   onPressed: () {
//                     // 카카오 로그인 로직 추가
//                   },
//                 ),
//               ],
//             ),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // 이메일 로그인 로직 추가
//                   },
//                   child: Text('이메일로 로그인'),
//                 ),
//                 Text('|'),
//                 TextButton(
//                   onPressed: () {
//                     // 이메일 가입 로직 추가
//                   },
//                   child: Text('이메일로 가입'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSocialLoginButton({
//     required Color color,
//     required IconData icon,
//     required String text,
//     Color textColor = Colors.white,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, color: textColor),
//       label: Text(
//         text,
//         style: TextStyle(color: textColor),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         minimumSize: Size(double.infinity, 48),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleNaverLogin(BuildContext context) async {
//     try {
//       final NaverLoginResult result = await FlutterNaverLogin.logIn();
//       if (result.status == NaverLoginStatus.loggedIn) {
//         final accessToken = result.account?.id;
//         final email = result.account?.email;
//         final name = result.account?.name;
//
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('로그인 성공'),
//             content: Text('환영합니다, $name ($email) 님!'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('확인'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('로그인 실패'),
//             content: Text('네이버 로그인에 실패했습니다. 다시 시도해주세요.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('확인'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('오류 발생'),
//           content: Text('로그인 중 오류가 발생했습니다: $e'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('확인'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
