import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/screens/mypage_screen.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class BookPictorialBookScreen extends StatefulWidget {
  static const String id = 'book_pictorial_book';

  @override
  State<BookPictorialBookScreen> createState() =>
      _BookPictorialBookScreenState();
}

class _BookPictorialBookScreenState extends State<BookPictorialBookScreen> {
  final List<Map<String, dynamic>> badgeData = [
    {'title': '초보 독서왕', 'active': true},
    {'title': '책을 사랑하는 당신', 'active': true},
    {'title': '독서 기록의 시작', 'active': false},
    {'title': '차곡차곡', 'active': false},
    {'title': '초보 출석왕', 'active': false},
    {'title': '독서 첫단추', 'active': false},
    {'title': '기록 기록의 시작', 'active': false},
    {'title': '꾸준한 기록가', 'active': false},
    {'title': '작가의 시작', 'active': false}
  ];

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
              height: bodyHeight,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Distribute space
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: bodyWidth * (20 / kDeviceWidth),
                          vertical: bodyHeight * (12 / kDeviceHeight)),
                      child: Container(
                        height: bodyHeight * (34 / kDeviceHeight),
                        width: bodyWidth * (320 / kDeviceWidth),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/black_clover.svg',
                                width: bodyWidth * (16 / kDeviceWidth),
                                height: bodyHeight * (16 / kDeviceHeight),
                              ),
                            ),
                            SizedBox(
                              width: bodyWidth * (4 / kDeviceWidth),
                            ),
                            Container(
                              child: SvgPicture.asset(
                                'assets/images/bookluck_text.svg',
                                width: bodyWidth * (93 / kDeviceWidth),
                                height: bodyHeight * (16 / kDeviceHeight),
                              ),
                            ),
                            SizedBox(
                              width: bodyWidth * (103 / kDeviceWidth),
                            ),
                            Container(
                              width: bodyWidth * (104 / kDeviceWidth),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, MyPageScreen.id);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/book_at_mypage.svg',
                                      width: bodyWidth * (24 / kDeviceWidth),
                                      height: bodyHeight * (24 / kDeviceHeight),
                                    ),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (16 / kDeviceWidth),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/blank_clover.svg',
                                    width: bodyWidth * (24 / kDeviceWidth),
                                    height: bodyHeight * (24 / kDeviceHeight),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (16 / kDeviceWidth),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/cogwheel.svg',
                                    width: bodyWidth * (24 / kDeviceWidth),
                                    height: bodyHeight * (24 / kDeviceHeight),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: bodyWidth * (20 / kDeviceWidth),
                          vertical: bodyHeight * (14 / kDeviceHeight)),
                      child: Container(
                        width: bodyWidth * (360 / kDeviceWidth),
                        height: bodyHeight * (76 / kDeviceHeight),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '북럭 도감',
                              style: kTextStyle20(context,
                                  weight: FontWeight.w600),
                            ),
                            Text(
                              '책을 읽으며 새로운 북럭이 찾아보세요',
                              style: kTextStyle14(context,
                                  weight: FontWeight.w500, opacity: 0.4),
                            )
                          ],
                        ),
                      ),
                    ),
                    // 북럭 미션
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: bodyWidth * (20 / kDeviceWidth),
                          vertical: bodyHeight * (12 / kDeviceHeight)),
                      child: Container(
                        width: bodyWidth * (320 / kDeviceWidth),
                        height: bodyHeight * (460 / kDeviceHeight),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0x1F303030))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: bodyHeight * (20 / kDeviceHeight),
                            ),
                            SvgPicture.asset(
                              'assets/images/book_luck_mission.svg',
                              // width: bodyWidth * (24 / kDeviceWidth),
                              height: bodyHeight * (14 / kDeviceHeight),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: List.generate(
                                (badgeData.length / 3).ceil(), // number of rows
                                (rowIndex) {
                                  final start = rowIndex * 3;
                                  final end = (start + 3 < badgeData.length)
                                      ? start + 3
                                      : badgeData.length;
                                  final rowItems =
                                      badgeData.sublist(start, end);

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: rowItems.map((item) {
                                      final isActive = item['active'] as bool;
                                      return Container(
                                        height:
                                            bodyHeight * (112 / kDeviceHeight),
                                        width: bodyWidth * (96 / kDeviceWidth),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              isActive
                                                  ? 'assets/images/small_green_clover.svg'
                                                  : 'assets/images/small_clover.svg',
                                              width: bodyWidth *
                                                  (62 / kDeviceWidth),
                                              height: bodyHeight *
                                                  (62 / kDeviceHeight),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              item['title'] as String,
                                              textAlign: TextAlign.center,
                                              style: kTextStyle12(
                                                context,
                                                weight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                                height: 56 * (bodyHeight / kDeviceHeight),
                                width: 288 * (bodyWidth / kDeviceWidth),
                                decoration: BoxDecoration(
                                  color: Color(0x0F56698F),
                                  borderRadius: BorderRadius.circular(8),
                                  // border:
                                  //     Border.all(color: Color(0x1F303030))
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/lock.svg',
                                      width: bodyWidth * (15 / kDeviceWidth),
                                      height:
                                          bodyHeight * (18.33 / kDeviceHeight),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'NEXT STAGE',
                                      style:
                                          kTextStyle14(context, opacity: 0.6),
                                    )
                                  ],
                                ))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: bodyHeight * (8 / kDeviceHeight),
                      decoration: BoxDecoration(
                          color: Color(0xFF56698F).withOpacity(0.04)),
                    )
                  ]))),
    )));
  }
}
