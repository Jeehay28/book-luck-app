import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:book_luck_app_demo/screens/bookshelf_screen.dart';
import 'package:book_luck_app_demo/screens/feed_screen.dart';
import 'package:book_luck_app_demo/screens/mypage_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/utils/home_icon_icons.dart';
import 'package:book_luck_app_demo/utils/feed_icon_icons.dart';
import 'package:book_luck_app_demo/utils/bookshelf_icon_icons.dart';

class MainScreen extends StatefulWidget {
  final int initialTab;

  MainScreen({this.initialTab = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

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
              icon: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  'assets/images/my_page.svg',
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                ),
              ),
              label: '마이 페이지',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }
}
