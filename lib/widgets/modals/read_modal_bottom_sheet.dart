import 'package:book_luck_app_demo/screens/book_select_screen.dart';
import 'package:book_luck_app_demo/screens/book_search_screen.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/svg.dart';

class ReadModalBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;
    return Container(
      height: bodyHeight * (260 / kDeviceHeight),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: bodyWidth * (10 / kDeviceWidth)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NN분 NN초 읽었습니다.', style: kTextStyle14(context, opacity: 0.4)),
            SizedBox(
              height: 10,
            ),
            Text('어떤 책을 읽으셨나요?', style: kTextStyle14(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, BookSearchScreen.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: bodyHeight * (120 / kDeviceHeight),
                      width: bodyWidth * (150 / kDeviceWidth),
                      decoration: BoxDecoration(
                        color:
                            Color(0xff56698f).withAlpha((0.06 * 255).round()),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/reading.svg',
                              width: bodyWidth * (24 / kDeviceWidth),
                              height: bodyHeight * (24 / kDeviceHeight),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('새로운 책을 \n읽었어요', style: kTextStyle14(context))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, BookSelectScreen.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: bodyHeight * (120 / kDeviceHeight),
                      width: bodyWidth * (150 / kDeviceWidth),
                      decoration: BoxDecoration(
                        color:
                            Color(0xff56698f).withAlpha((0.06 * 255).round()),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/newBook.svg',
                              width: bodyWidth * (24 / kDeviceWidth),
                              height: bodyHeight * (24 / kDeviceHeight),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('읽고 있던 책을 \n읽었어요',
                                style: kTextStyle14(context))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
