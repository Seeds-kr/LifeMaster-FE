import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavigation({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, '홈', 0),
          _buildNavItem(Icons.group, '그룹', 1),
          _buildNavItem(Icons.favorite_border, '커뮤니티', 2),
          _buildNavItem(Icons.menu, '전체', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selectedIndex == index ? Colors.blue : Colors.grey),
          Text(
            label,
            style: TextStyle(color: selectedIndex == index ? Colors.blue : Colors.grey),
          ),
        ],
      ),
    );
  }
}
