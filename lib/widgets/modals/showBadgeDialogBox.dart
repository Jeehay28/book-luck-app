import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/screens/book_review_write_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> showBadgeDialogBox(
    BuildContext context,
    String badgeName,
    int numberOfBadges,
    String cancel,
    String confirm,
    Color backgroundColor,
    VoidCallback onConfirmPressed) async {
  final bodyHeight = context.bodyHeight;
  final bodyWidth = context.bodyWidth;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: bodyWidth * (280 / kDeviceWidth),
          height: bodyHeight * (382 / kDeviceHeight),
          padding: EdgeInsets.symmetric(
              vertical: bodyHeight * (12 / kDeviceHeight),
              horizontal: bodyWidth * (20 / kDeviceWidth)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.zero,
                  height: bodyHeight * (94 / kDeviceHeight),
                  width: bodyWidth * (240 / kDeviceWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        badgeName,
                        // 뱃지명
                        style: kTextStyle18(context),
                      ),
                      Text(
                        '뱃지를 획득했습니다!',
                        // 뱃지명
                        style: kTextStyle18(context),
                      ),
                      Text(
                        '현재 획득한 뱃지 갯수는 $numberOfBadges개 입니다.',
                        // 뱃지명
                        style: kTextStyle14(context,
                            color: Color(0xff18253d), opacity: 0.6),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: bodyHeight * (40 / kDeviceHeight)),
                child: SvgPicture.asset(
                  'assets/images/clover_badge.svg',
                ),
              ),
              Container(
                height: bodyHeight * (102 / kDeviceHeight),
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, BookReviewCompleteScreen.id);
                          onConfirmPressed();
                        },
                        style: TextButton.styleFrom(
                          // backgroundColor: Color(0xff303030),
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white, // 배경색
                          minimumSize: Size(bodyWidth * (240 / kDeviceWidth),
                              bodyHeight * (40 / kDeviceHeight)), // 너비와 높이
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                            // '완독했어요'
                            confirm)),
                    SizedBox(
                      height: bodyHeight * (8 / kDeviceHeight),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Color(0xff56698f).withAlpha((0.06 * 255).round()),
                          foregroundColor: Colors.black, // 배경색
                          minimumSize: Size(bodyWidth * (240 / kDeviceWidth),
                              bodyHeight * (40 / kDeviceHeight)), // 너비와 높이
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(cancel)),
                  ],
                ),
              )

              // 다른 위젯들
            ],
          ),
        ),
      );
    },
  );
}
