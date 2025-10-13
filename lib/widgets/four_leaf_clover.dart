import 'dart:async'; // For Timer
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class FourLeafCloverContainer extends StatefulWidget {
  @override
  _FourLeafCloverContainerState createState() =>
      _FourLeafCloverContainerState();
}

class _FourLeafCloverContainerState extends State<FourLeafCloverContainer> {
  final List<String> lottieFiles = [
    'assets/lottie/test_lottie_01.json'
    // 'assets/lottie/basic.json',
    // 'assets/lottie/dance.json',
    // 'assets/lottie/heart.json',
    // 'assets/lottie/poppingClover.json',
    // 'assets/lottie/rainbow.json',
    // 'assets/lottie/reading.json',
    // 'assets/lottie/record1.json',
    // 'assets/lottie/record2.json',
    // 'assets/lottie/sad.json'
  ];
  int _currentIndex = 0;

  late Timer _timer;
  bool _showFirstImage = true; // Tracks which image to show

  @override
  void initState() {
    super.initState();
    // Initialize the timer to toggle images every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex =
            (_currentIndex + 1) % lottieFiles.length; // Toggle image state
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Container(
      height: bodyHeight * 0.3554, // 35.54% of screen height, 252,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent, // Border color
          width: 1, // Border width
        ),
        color: Colors.transparent, // Transparent background
        borderRadius:
            BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
      ),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff56698f).withAlpha((0.04 * 255).round()),
            fixedSize:
                Size(bodyWidth * 0.8889, bodyHeight * 0.3385), // Button size
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)), // Corners
            ),
            elevation: 0, // Remove shadow
          ),
          onPressed: () {
            // Action for the button
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   _showFirstImage
              //       ? 'assets/images/layer_1.svg' // First image path
              //       : 'assets/images/layer_2.svg', // Second image path
              //
              // ),
              Lottie.asset(
                lottieFiles[_currentIndex],
                width: bodyWidth * (200 / kDeviceWidth),
                height: bodyHeight * (200 / kDeviceHeight),
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
