import 'package:book_luck_app_demo/screens/feed_screen.dart';
import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/widgets/modals/showBadgeDialogBox.dart';

class BookReviewCompleteScreen extends StatefulWidget {
  static const String id = 'book_review_complete';

  @override
  State<BookReviewCompleteScreen> createState() =>
      _BookReviewCompleteScreenState();
}

class _BookReviewCompleteScreenState extends State<BookReviewCompleteScreen> {
  bool _dialogShown = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown) {
        _dialogShown = true;

        showBadgeDialogBox(
          context,
          '북럭이 뱃지',
          1,
          '닫기',
          '나의 도감 보러가기',
          Color(0xff303030),
          () {
            print('북럭이 뱃지');
            ;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;

    final bool isChecked = false;

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: bodyWidth * (20 / kDeviceWidth),
            vertical: bodyHeight * (20 / kDeviceHeight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: bodyHeight * (57 / kDeviceHeight),
            ),
            Text(
              '독후감 작성을 완료했습니다!',
              style: kTextStyle24(context),
              textAlign: TextAlign.start,
            ),
            Text(
              '해당 책의 기록은 N개입니다.',
              style:
                  kTextStyle16(context, weight: FontWeight.w500, opacity: 0.6),
            ),
            Container(
              height: bodyHeight * (300 / kDeviceHeight),
              padding: EdgeInsets.symmetric(
                  horizontal: 80, vertical: bodyHeight * (50 / kDeviceHeight)),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/bookluck_writing.svg',
                  // width: bodyWidth * (200 / kDeviceWidth),
                  // height: bodyHeight * (200 / kDeviceHeight),
                ),
              ),
            ),
            SizedBox(
              height: bodyHeight * (110 / kDeviceHeight),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, FeedScreen.id);
              },
              child: Text(
                '독후감 보러가기',
                style: kTextStyle16(context, color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff303030),
                foregroundColor: Colors.white,
                // 배경색
                minimumSize: Size(bodyWidth * (320 / kDeviceWidth),
                    bodyHeight * (56 / kDeviceHeight)),
                // 너비와 높이
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: bodyHeight * (12 / kDeviceHeight),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
              child: Text(
                '홈으로 가기',
                style: kTextStyle16(context, color: Colors.black),
              ),
              style: TextButton.styleFrom(
                backgroundColor:
                    Color(0xff56698f).withAlpha((0.06 * 255).round()),
                foregroundColor: Colors.black,
                // 배경색
                minimumSize: Size(bodyWidth * (320 / kDeviceWidth),
                    bodyHeight * (56 / kDeviceHeight)),
                // 너비와 높이
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    ])));
  }
}
