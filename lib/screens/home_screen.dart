import 'package:flutter/material.dart';
import 'package:book_luck_app/widgets/StartReadingButton.dart';
import 'package:book_luck_app/widgets/BookluckContainer.dart';
import 'package:book_luck_app/widgets/QuoteContainer.dart';
import 'package:book_luck_app/widgets/FourLeafCloverContainer.dart';
import 'package:book_luck_app/widgets/ReadingTimeBar.dart';
import 'package:book_luck_app/widgets/GoalCountdown.dart';
import 'package:book_luck_app/widgets/BottomMenu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Add some padding for the sides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1) BOOKLUCK 로고 : 360 * 58 (8.18% of screen height)
            BookluckContainer(heightFactor: 0.0818),

            // 2) 명언 박스 : 360 * 122 (17.21% of screen height)
            QuoteContainer(heightFactor: 0.1721),

            // 3) 네잎클로버 로고 : 360 *252 (35.54% of screen height)
            FourLeafCloverContainer(heightFactor: 0.3554),

            // 4) 0분-30분-1시간 : 360 * 70 (9.87% of screen height)
            ReadingtimeBar(heightFactor: 0.0987),

            // 5) 목표까지 : 360 * 57 (8.04% of screen height)
            GoalCountdown(heightFactor: 0.0804),

            // 6) 독서시작하기 : 360 *80 (11.28% of screen height)
            StartReadingButton(heightFactor: 0.1128),

            // 7) 홈/책장/피드/마이페이지 : 360 * 104 (9.87% of screen height)
            BottomMenu(heightFactor: 0.0987),
          ],
        ),
      ),
    );
  }
}
