import 'package:book_luck_app_demo/providers/recently_searched_books.dart';
import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';
import 'package:book_luck_app_demo/screens/book_review_write_screen.dart';
import 'package:book_luck_app_demo/screens/book_select_screen.dart';
import 'package:book_luck_app_demo/screens/setting_screen.dart';
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
import 'package:book_luck_app_demo/screens/main_screen.dart';
import 'package:book_luck_app_demo/screens/book_search_screen.dart';
import 'package:book_luck_app_demo/screens/book_review_list_screen.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MinutesProvider()),
        ChangeNotifierProvider(create: (_) => RecentlySearchedBooksProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// AppLinks 인스턴스 생성 및 스트림 구독 준비
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLink();
  }

  void _initDeepLink() async {
    _appLinks = AppLinks();

    // 앱이 꺼져있을 때 딥링크로 들어온 경우 처리 (Initial Link)
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleLink(initialUri.toString());
      }
    } catch (e) {
      print("초기 딥링크 에러: $e");
    }

    // 4. 앱이 켜져있을 때 딥링크가 들어오는 경우 감지 (Stream)
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleLink(uri.toString());
      },
      onError: (err) {
        print("딥링크 스트림 에러: $err");
      },
    );
  }

  void _handleLink(String link) {
    print("딥링크 수신: $link");

    // 기존 로직 유지
    if (link.contains("login/success")) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        HomeScreen.id,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    // 구독 해제
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Book Luck App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, // Set default background color
        ),
        initialRoute: LandingPage.id,
        // initialRoute: HomeScreen.id,
        routes: {
          LandingPage.id: (context) => LandingPage(),
          OnboardingPage.id: (context) => OnboardingPage(),
          LoginPage.id: (context) => LoginPage(),
          HomeScreen.id: (context) => MainScreen(initialTab: 0),
          BookshelfScreen.id: (context) => MainScreen(initialTab: 1),
          FeedScreen.id: (context) => MainScreen(initialTab: 2),
          MyPageScreen.id: (context) => MainScreen(initialTab: 3),
          BookSearchScreen.id: (context) => BookSearchScreen(),
          BookSelectScreen.id: (context) => BookSelectScreen(),
          BookReviewCompleteScreen.id: (context) => BookReviewCompleteScreen(),
          SettingScreen.id: (context) => SettingScreen()
        },
        onGenerateRoute: (settings) {
          print(settings);
          switch (settings.name) {
            case BookReviewWriteScreen.id:
              final args = settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                builder: (context) => BookReviewWriteScreen(
                  title: args['title']!,
                  author: args['author']!,
                  image: args['image']!,
                  isbn: args['isbn']!,
                ),
              );

            case BookReviewListScreen.id:
              final args = settings.arguments as Map<String, dynamic>;
              print('book review list screen :');
              print(args);
              return MaterialPageRoute(
                builder: (context) => BookReviewListScreen(
                  title: args['title']!,
                  author: args['author']!,
                  image: args['image']!,
                  isbn: args['isbn'] ?? "",
                ),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => LandingPage(),
              );
          }
        });
  }
}
