import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SlideToggle extends StatefulWidget {
  const SlideToggle({super.key});

  @override
  State<SlideToggle> createState() => _SlideToggleState();
}

class _SlideToggleState extends State<SlideToggle> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: Container(
          width: bodyWidth * (32 / kDeviceWidth),
          height: bodyHeight * (20 / kDeviceHeight),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: bodyWidth * (10 / kDeviceWidth),
              height: bodyHeight * (10 / kDeviceHeight),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOn ? Color(0xFF59BE92) : Color(0XFFD5D5D5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
