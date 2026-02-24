import 'package:flutter/material.dart';
// Import các Models và Data
import '../models/comic_model.dart'; 
import '../data/mock_data.dart'; // Lấy dữ liệu xịn từ file mock_data.dart

// Import các Screens
import 'recomment_screen.dart'; 
import 'comics_screen.dart'; 
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Khởi tạo danh sách màn hình (Chỉ giữ lại 3 màn hình có logic)
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      RecommentScreen(comics: mockComics), 
      ComicsScreen(comics: mockComics), 
      const ProfileScreen(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.orange, 
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // fixed giúp các icon không bị nhảy múa
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            activeIcon: Icon(Icons.home), 
            label: 'Đề xuất'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined), 
            activeIcon: Icon(Icons.menu_book), 
            label: 'Truyện tranh' 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), 
            activeIcon: Icon(Icons.person), 
            label: 'Tôi'
          ),
        ],
      ),
    );
  }
}