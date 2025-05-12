import 'package:flutter/material.dart';

class EditHomeScreen extends StatefulWidget {
  final List<String> initialActiveFeatures;

  EditHomeScreen({required this.initialActiveFeatures});

  @override
  _EditHomeScreenState createState() => _EditHomeScreenState();
}

class _EditHomeScreenState extends State<EditHomeScreen> {
  late List<String> activeFeatures;
  List<String> availableFeatures = ["수면", "자아성찰", "챌린지", "디톡스"];

  @override
  void initState() {
    super.initState();
    activeFeatures = List<String>.from(widget.initialActiveFeatures);
  }

  void _addFeature(int index) {
    setState(() {
      String added = availableFeatures.removeAt(index);
      activeFeatures.add(added);
    });
  }

  void _removeFeature(int index) {
    setState(() {
      String removed = activeFeatures.removeAt(index);
      availableFeatures.add(removed);
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
            // 활성화된 기능
            Text("전체 서비스",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: activeFeatures.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(activeFeatures[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeFeature(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // 비활성화된 기능
            Text("모든 기능",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: availableFeatures.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(availableFeatures[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => _addFeature(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // 저장 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, activeFeatures);
              },
              child: Text("저장하기"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
