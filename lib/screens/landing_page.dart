import 'package:flutter/material.dart';
import 'onboarding.dart'; // Import OnboardingPage

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    // Navigate to OnboardingPage after a delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OnboardingPage()), // No const here
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', // Path to your logo
          width: 150, // Adjust the size of the logo as needed
          height: 150,
        ),
      ),
    );
  }
}
