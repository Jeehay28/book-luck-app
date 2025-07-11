import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';

class MyPageScreen extends StatelessWidget {
  static const String id = 'mypage';

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.zero, // Add some padding for the sides
            child: SizedBox(
              height: bodyHeight,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Distribute space
                  children: [
                    Text(
                      "My Page Screen", // Add your desired button label here
                      style: TextStyle(
                        color: Color(0xFF303030), // Text color
                        fontFamily: 'SUITVariable',
                        fontSize: 0.0389 * bodyWidth, // Text size
                        fontWeight: FontWeight.w700,
                        height:
                            1.42, // Correct height as a ratio to the font size
                        letterSpacing: -0.28,
                      ),
                    )
                  ]),
            )),
      ),
    );
  }
}
