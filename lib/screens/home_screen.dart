import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/widgets/start_reading_button.dart';
import 'package:book_luck_app_demo/widgets/book_luck.dart';
import 'package:book_luck_app_demo/widgets/quotes.dart';
import 'package:book_luck_app_demo/widgets/four_leaf_clover.dart';
import 'package:book_luck_app_demo/widgets/reading_time_bar.dart';
import 'package:book_luck_app_demo/widgets/goal_countdown.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 1) BOOKLUCK 로고 : 360 * 58 (8.18% of screen height)
                BookluckContainer(),

                // 2) 명언 박스 : 360 * 122 (17.21% of screen height)
                QuoteContainer(),

                // 3) 네잎클로버 로고 : 360 *252 (35.54% of screen height)
                FourLeafCloverContainer(),

                // 4) 0분-30분-1시간 : 360 * 70 (9.87% of screen height)
                ReadingtimeBar(),

                // 5) 목표까지 : 360 * 57 (8.04% of screen height)
                GoalCountdown(),

                // 6) 독서 시작하기 : 360 *80 (11.28% of screen height)
                StartReadingButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
