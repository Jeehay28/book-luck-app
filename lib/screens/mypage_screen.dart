import 'package:book_luck_app_demo/screens/setting_screen.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
import 'book_luck_stamps_screen.dart';
import 'book_receipt_screen.dart';

class MyPageScreen extends StatefulWidget {
  static const String id = 'mypage';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    BookReceiptScreen(),
    BookLuckStampsScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.zero, // Add some padding for the sides
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
                                            setState(() {
                                              selectedIndex = 0;
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/book_at_mypage.svg',
                                            width:
                                                bodyWidth * (24 / kDeviceWidth),
                                            height: bodyHeight *
                                                (24 / kDeviceHeight),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              bodyWidth * (16 / kDeviceWidth),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 1;
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/blank_clover.svg',
                                            width:
                                                bodyWidth * (24 / kDeviceWidth),
                                            height: bodyHeight *
                                                (24 / kDeviceHeight),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              bodyWidth * (16 / kDeviceWidth),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 2;
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/cogwheel.svg',
                                            width:
                                                bodyWidth * (24 / kDeviceWidth),
                                            height: bodyHeight *
                                                (24 / kDeviceHeight),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: screens[selectedIndex]))
                        ])))));
  }
}
