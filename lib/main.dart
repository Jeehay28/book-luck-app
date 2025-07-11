import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/landing_page.dart';
import 'screens/onboarding.dart';
import 'screens/login_page.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/minutes_provider.dart';
import 'screens/bookshelf_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/mypage_screen.dart';
import 'package:book_luck_app_demo/widgets/BottomMenu.dart';
import 'package:book_luck_app_demo/providers/route_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/utils/my_page_icons.dart';
import 'package:book_luck_app_demo/utils/home_icon_icons.dart';
import 'package:book_luck_app_demo/utils/feed_icon_icons.dart';
import 'package:book_luck_app_demo/utils/bookshelf_icon_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Lock the orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MinutesProvider()),
        // ChangeNotifierProvider(create: (_) => RouteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Luck App',
      theme: ThemeData(
        // primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white, // Set default background color
      ),
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context) => LandingPage(),
        OnboardingPage.id: (context) => OnboardingPage(),
        LoginPage.id: (context) => LoginPage(),
        HomeScreen.id: (context) => MainScreen(),
        BookshelfScreen.id: (context) => MainScreen(),
        FeedScreen.id: (context) => MainScreen(),
        MyPageScreen.id: (context) => MainScreen(),
      },
    );
  }
}

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
        body: Center(child: _screens.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          // showUnselectedLabels: true,
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
