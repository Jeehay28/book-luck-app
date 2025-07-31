import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';
import 'package:book_luck_app_demo/screens/book_review_write_screen.dart';
import 'package:book_luck_app_demo/screens/book_select_screen.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MinutesProvider()),
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
          BookReviewCompleteScreen.id: (context) => BookReviewCompleteScreen()
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case BookReviewWriteScreen.id:
              final args = settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                builder: (context) => BookReviewWriteScreen(
                  title: args['title']!,
                  author: args['author']!,
                  image: args['image']!,
                ),
              );

            case BookReviewListScreen.id:
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (context) => BookReviewListScreen(
                        title: args['title']!,
                        author: args['author']!,
                        image: args['image']!,
                      ));

            default:
              return MaterialPageRoute(
                builder: (context) => LandingPage(),
              );
          }
        });
  }
}
