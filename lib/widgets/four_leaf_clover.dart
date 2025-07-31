import 'dart:async'; // For Timer
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FourLeafCloverContainer extends StatefulWidget {
  @override
  _FourLeafCloverContainerState createState() =>
      _FourLeafCloverContainerState();
}

class _FourLeafCloverContainerState extends State<FourLeafCloverContainer> {
  late Timer _timer;
  bool _showFirstImage = true; // Tracks which image to show

  @override
  void initState() {
    super.initState();
    // Initialize the timer to toggle images every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _showFirstImage = !_showFirstImage; // Toggle image state
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
            backgroundColor: const Color.fromRGBO(86, 105, 143, 0.04),
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
              SvgPicture.asset(
                _showFirstImage
                    ? 'assets/images/layer_1.svg' // First image path
                    : 'assets/images/layer_2.svg', // Second image path
                // 'assets/images/home_clover.gif',
                // height: bodyHeight * (200 / kDeviceHeight),
                // width: bodyWidth * (200 / kDeviceWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
