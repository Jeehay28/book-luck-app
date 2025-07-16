import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/screens/book_review_write_screen.dart';

Future<void> showDialogBox(BuildContext context, String title, String content,
    String cancel, String confirm, Color backgroundColor) async {
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
          height: bodyHeight * (170 / kDeviceHeight),
          padding: EdgeInsets.symmetric(
              vertical: bodyHeight * (12 / kDeviceHeight),
              horizontal: bodyWidth * (20 / kDeviceWidth)),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.zero,
                  height: bodyHeight * (94 / kDeviceHeight),
                  width: bodyWidth * (240 / kDeviceWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        // '해당 책을 완독하셨나요?',
                        style: kTextStyle14(context),
                      ),
                      SizedBox(
                        height: 7 * (bodyHeight / kDeviceHeight),
                      ),
                      Text(
                        // '🎉 완독 축하드려요!\n이제 이 책은 당신의 멋진 독서 이력에 당당히 등록됩니다.',
                        content,
                        style: kTextStyle12(context, opacity: 0.4),
                      ),
                    ],
                  )),

              Container(
                height: bodyHeight * (40 / kDeviceHeight),
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Color(0xff56698f).withAlpha((0.06 * 255).round()),
                          foregroundColor: Colors.black, // 배경색
                          minimumSize: Size(bodyWidth * (116 / kDeviceWidth),
                              bodyHeight * (40 / kDeviceHeight)), // 너비와 높이
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(cancel)),
                    SizedBox(
                      width: bodyWidth * (4 / kDeviceWidth),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, BookReviewCompleteScreen.id);
                        },
                        style: TextButton.styleFrom(
                          // backgroundColor: Color(0xff303030),
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white, // 배경색
                          minimumSize: Size(bodyWidth * (116 / kDeviceWidth),
                              bodyHeight * (40 / kDeviceHeight)), // 너비와 높이
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                            // '완독했어요'
                            confirm))
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
