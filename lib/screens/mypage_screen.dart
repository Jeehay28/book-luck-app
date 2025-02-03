import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top // Exclude SafeArea top padding
        -
        MediaQuery.of(context)
            .padding
            .bottom; // Exclude SafeArea bottom padding

    final bodyWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left - // Exclude SafeArea left padding
        MediaQuery.of(context).padding.right; // Exclude SafeArea right padding

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
