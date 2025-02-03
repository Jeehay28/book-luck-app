import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
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
                      "Feed", // Add your desired button label here
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
                    // 1) BOOKLUCK 로고 : 360 * 58 (8.18% of screen height)
                    // BookluckContainer(
                    //     bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                    // // 2) 명언 박스 : 360 * 122 (17.21% of screen height)
                    // QuoteContainer(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                    // // 3) 네잎클로버 로고 : 360 *252 (35.54% of screen height)
                    // FourLeafCloverContainer(
                    //     bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                    // // 4) 0분-30분-1시간 : 360 * 70 (9.87% of screen height)
                    // ReadingtimeBar(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                    // // 5) 목표까지 : 360 * 57 (8.04% of screen height)
                    // GoalCountdown(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                    // // 6) 독서시작하기 : 360 *80 (11.28% of screen height)
                    // StartReadingButton(
                    //     bodyHeight: bodyHeight, bodyWidth: bodyWidth),
                  ]),
            )),
      ),
      // bottomNavigationBar: BottomMenu(
      //   bodyHeight: bodyHeight,
      //   bodyWidth: bodyWidth,
      //   currentRoute: currentRoute,
      // ),
    );
  }
}
