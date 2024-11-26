import 'package:flutter/material.dart';

class EditHomeScreen extends StatefulWidget {
  final List<String> activeFeatures;

  EditHomeScreen({required this.activeFeatures});

  @override
  _EditHomeScreenState createState() => _EditHomeScreenState();
}

class _EditHomeScreenState extends State<EditHomeScreen> {
  late List<String> activeFeatures;
  late List<String> availableFeatures;

  // 전체 기능 목록을 유지하여, 사용자가 삭제한 기능을 다시 추가할 수 있도록 함
  final List<String> allFeatures = [
    "달력",
    "할일",
    "수면",
    "자아성찰",
    "챌린지",
    "디톡스",
    "앱 잠금 설정",
    "자유 게시판",
    "개선 게시판",
    "알람 추가"
  ];

  @override
  void initState() {
    super.initState();
    activeFeatures = List.from(widget.activeFeatures);
    // allFeatures에서 activeFeatures에 없는 항목만 availableFeatures에 포함시킴
    availableFeatures = allFeatures
        .where((feature) => !activeFeatures.contains(feature))
        .toList();
  }

  void _addFeature(String feature) {
    setState(() {
      availableFeatures.remove(feature);
      activeFeatures.add(feature);
    });
  }

  void _removeFeature(String feature) {
    setState(() {
      activeFeatures.remove(feature);
      availableFeatures.add(feature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈 화면 편집"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, activeFeatures),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("전체 서비스",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...activeFeatures
                .map((feature) => ListTile(
                      title: Text(feature),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeFeature(feature),
                      ),
                    ))
                .toList(),
            SizedBox(height: 16),
            Text("모든 기능",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...availableFeatures
                .map((feature) => ListTile(
                      title: Text(feature),
                      trailing: IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () => _addFeature(feature),
                      ),
                    ))
                .toList(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, activeFeatures);
              },
              child: Text("저장하기"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
