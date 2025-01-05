import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/onboarding.dart';
import 'screens/login_page.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/minutes_provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
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
        primarySwatch: Colors.deepPurple,
      ),
      home:
          LandingPage(), // Removed const because LandingPage isn't a const widget
      routes: {
        '/onboarding': (context) =>
            OnboardingPage(), // Add OnboardingPage route
        '/login': (context) => LoginPage(), // Add LoginPage route
        '/home': (context) => HomeScreen()
      },
    );
  }
}
