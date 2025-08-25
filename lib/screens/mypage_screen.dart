import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/svg.dart';

class MyPageScreen extends StatefulWidget {
  static const String id = 'mypage';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String selectedTab = '기록';

  final List<String> options = ['최신순', '오래된순'];

  String dropdownValue = '최신순';

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
                                  SvgPicture.asset(
                                    'assets/images/book_at_mypage.svg',
                                    width: bodyWidth * (24 / kDeviceWidth),
                                    height: bodyHeight * (24 / kDeviceHeight),
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
                          horizontal: bodyWidth * (20 / kDeviceWidth)),
                      child: Container(
                        height: bodyHeight * (52 / kDeviceHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    '기록 영수증',
                                    style: kTextStyle14(context),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (4 / kDeviceWidth),
                                  ),
                                  Text(
                                    '21',
                                    style: kTextStyle14(context, opacity: 0.4),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: bodyWidth * (71 / kDeviceWidth),
                                    height: bodyHeight * (32 / kDeviceHeight),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            bodyWidth * (8 / kDeviceWidth)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                      border: Border.all(
                                          color: Color(0xff303030).withAlpha(
                                              (0.08 * 255)
                                                  .round())), // Optional border
                                    ),
                                    child: DropdownButton<String>(
                                      value: options.contains(dropdownValue)
                                          ? dropdownValue
                                          : null,
                                      icon: SvgPicture.asset(
                                        'assets/images/angle_down.svg',
                                        width: bodyWidth * (14 / kDeviceWidth),
                                        height:
                                            bodyWidth * (14 / kDeviceHeight),
                                      ),
                                      iconSize:
                                          0, // set to 0 to avoid interference

                                      // Selected item style
                                      dropdownColor: Colors
                                          .white, // Background color of dropdown items
                                      underline: SizedBox
                                          .shrink(), // Remove underline // Dropdown icon
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: options.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: kTextStyle12(context,
                                                weight: FontWeight.w600),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (8 / kDeviceWidth),
                                  ),
                                  Container(
                                    width: bodyWidth * (32 / kDeviceWidth),
                                    height: bodyHeight * (32 / kDeviceHeight),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners
                                      border: Border.all(
                                          color: Color(0xff303030).withAlpha(
                                              (0.08 * 255)
                                                  .round())), // Optional border
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              bodyWidth * (6 / kDeviceWidth)),
                                      child: SvgPicture.asset(
                                        'assets/images/magnifying_glass.svg',
                                        width:
                                            bodyWidth * (15.83 / kDeviceWidth),
                                        height:
                                            bodyWidth * (15.83 / kDeviceWidth),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
            )),
      ),
    );
  }
}
