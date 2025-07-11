import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:book_luck_app_demo/screens/bookshelf_screen.dart';
import 'package:book_luck_app_demo/screens/feed_screen.dart';
import 'package:book_luck_app_demo/screens/mypage_screen.dart';
import 'package:book_luck_app_demo/utils/my_page_icons.dart';
import 'package:book_luck_app_demo/utils/home_icon_icons.dart';
import 'package:book_luck_app_demo/utils/feed_icon_icons.dart';
import 'package:book_luck_app_demo/utils/bookshelf_icon_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BookshelfScreen(),
    FeedScreen(),
    MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _screens.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(HomeIcon.home), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(BookshelfIcon.bookshelf), label: '책장'),
            BottomNavigationBarItem(icon: Icon(FeedIcon.feed), label: '피드'),
            BottomNavigationBarItem(
                icon: Icon(MyPageIcons.my_page), label: '마이 페이지'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }
}
