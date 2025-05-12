import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("커뮤니티")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("오늘의 투표",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text("1,253명이 참여했어요!", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  ElevatedButton(onPressed: () {}, child: Text("가나다라마")),
                  ElevatedButton(onPressed: () {}, child: Text("바사아자차")),
                  ElevatedButton(onPressed: () {}, child: Text("카타파하")),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("전체 글",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.article, color: Colors.grey),
                  title: Text("7월 베타 공지"),
                  subtitle: Row(
                    children: [
                      Text("LIFEMASTER",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.visibility, size: 16, color: Colors.grey),
                      Text(" 242"),
                      SizedBox(width: 10),
                      Icon(Icons.thumb_up, size: 16, color: Colors.grey),
                      Text(" 29"),
                    ],
                  ),
                  trailing:
                      Text("7월 18일", style: TextStyle(color: Colors.grey)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
