import 'package:flutter/material.dart';
import 'package:lifemaster_proj2/screen/workout_tracker_screen.dart';
import 'dart:math';
import 'dart:async';
import '../components/bottom_navigation.dart';

class MemoryGameScreen extends StatefulWidget {
  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final int gridSize = 5;
  late List<bool> tiles;
  late List<bool> selectedTiles;
  int currentPage = 1;
  bool isGameComplete = false;
  bool isPreviewPhase = true;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    tiles = List.generate(gridSize * gridSize, (index) => false);
    selectedTiles = List.generate(gridSize * gridSize, (index) => false);
    isPreviewPhase = true;

    final random = Random();
    int coloredTiles = 8;

    while (coloredTiles > 0) {
      int index = random.nextInt(tiles.length);
      if (!tiles[index]) {
        tiles[index] = true;
        coloredTiles--;
      }
    }

    Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isPreviewPhase = false;
        });
      }
    });
  }

  void checkTile(int index) {
    if (isGameComplete || isPreviewPhase) return;

    setState(() {
      selectedTiles[index] = true;

      if (!tiles[index]) {
        showGameOverDialog();
        return;
      }

      bool allFound = true;
      for (int i = 0; i < tiles.length; i++) {
        if (tiles[i] && !selectedTiles[i]) {
          allFound = false;
          break;
        }
      }

      if (allFound) {
        isGameComplete = true;
        showWinDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.grey[100],
        ),
        child: AlertDialog(
          title: Text(
            '게임 오버',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            '틀린 타일을 선택했습니다!',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  initializeGame();
                });
              },
              child: Text(
                '다시 시작',
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.grey[100],
        ),
        child: AlertDialog(
          title: Text(
            '축하합니다!',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            '모든 타일을 찾았습니다!',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  initializeGame();
                });
              },
              child: Text(
                '다시 시작',
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentDateTime() {
    final now = DateTime.now();
    return '${now.year}년 ${now.month}월 ${now.day}일';
  }

  String getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                getCurrentDateTime(),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Text(
              getCurrentTime(),
              style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                    isPreviewPhase ? '타일의 위치를 기억하세요!' : '기억한 타일을 찾으세요!',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: tiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => checkTile(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPreviewPhase
                            ? (tiles[index] ? Colors.brown[200] : Colors.white)
                            : (selectedTiles[index]
                            ? (tiles[index] ? Colors.brown[200] : Colors.red[200])
                            : Colors.white),
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('1 / 3'),
            ),
            BottomNavigation(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (index != 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => index == 0
                          ? WorkoutTrackerScreen()
                          : Scaffold(body: Center(child: Text('준비 중인 화면입니다.'))),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}