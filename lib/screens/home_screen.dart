import 'package:flutter/material.dart';
import 'package:book_luck_app/widgets/StartReadingButton.dart';
import 'package:book_luck_app/widgets/BookluckContainer.dart';
import 'package:book_luck_app/widgets/QuoteContainer.dart';
import 'package:book_luck_app/widgets/FourLeafCloverContainer.dart';
import 'package:book_luck_app/widgets/ReadingTimeBar.dart';
import 'package:book_luck_app/widgets/GoalCountdown.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        // MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final bodyWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left - // Exclude SafeArea left padding
        MediaQuery.of(context).padding.right; // Exclude SafeArea right padding

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 1) BOOKLUCK 로고 : 360 * 58 (8.18% of screen height)
                BookluckContainer(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                // 2) 명언 박스 : 360 * 122 (17.21% of screen height)
                QuoteContainer(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                // 3) 네잎클로버 로고 : 360 *252 (35.54% of screen height)
                FourLeafCloverContainer(
                    bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                // 4) 0분-30분-1시간 : 360 * 70 (9.87% of screen height)
                ReadingtimeBar(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                // 5) 목표까지 : 360 * 57 (8.04% of screen height)
                GoalCountdown(bodyHeight: bodyHeight, bodyWidth: bodyWidth),

                // 6) 독서시작하기 : 360 *80 (11.28% of screen height)
                StartReadingButton(
                    bodyHeight: bodyHeight, bodyWidth: bodyWidth),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
