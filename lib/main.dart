import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/onboarding.dart';
import 'screens/login_page.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/minutes_provider.dart';
import 'screens/bookshelf_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/mypage_screen.dart';
import 'package:book_luck_app/widgets/BottomMenu.dart';
import 'package:book_luck_app/providers/route_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MinutesProvider()),
        ChangeNotifierProvider(create: (_) => RouteProvider()),
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
      home: LandingPage(), // Set this to start from the '/home' route
      routes: {
        '/onboarding': (context) => OnboardingPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => MainScreen(),
        '/bookshelf': (context) => MainScreen(),
        '/feed': (context) => MainScreen(),
        '/mypage': (context) => MainScreen(),
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
  String currentRoute = '/home';

  final Map<String, Widget> screens = {
    '/home': HomeScreen(),
    '/bookshelf': BookshelfScreen(),
    '/feed': FeedScreen(),
    '/mypage': MyPageScreen(),
  };

  void updateRoute(String routeName) {
    print('Route updated to: $routeName');
    setState(() {
      currentRoute = routeName; // Update the current route
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current route from RouteProvider
    final currentRoute = Provider.of<RouteProvider>(context).currentRoute;

    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        // MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.zero,
          child: screens[currentRoute],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        bodyHeight: bodyHeight,
        bodyWidth: MediaQuery.of(context).size.width,
        currentRoute: currentRoute,
        onRouteChange: (routeName) {
          // Use RouteProvider to update the route globally
          Provider.of<RouteProvider>(context, listen: false)
              .updateRoute(routeName);
        },
      ),
    );
  }
}
