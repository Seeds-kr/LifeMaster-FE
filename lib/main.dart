import 'package:flutter/material.dart';
import 'screen/sleep_screen.dart';
import 'screen/playlist_screen.dart';

void main() => runApp(SleepApp());

class SleepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // 네비게이션이 포함된 메인 화면
      routes: {
        '/sleep': (context) => SleepScreen(),
        '/playlist': (context) => PlaylistScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PlaylistScreen(), // '홈'에 해당하는 화면
    Center(child: Text('그룹 페이지')),
    Center(child: Text('커뮤니티 페이지')),
    Center(child: Text('전체 페이지')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '그룹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '전체',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
