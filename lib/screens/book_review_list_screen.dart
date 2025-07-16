import 'package:book_luck_app_demo/widgets/review_list.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/widgets/calendar_page.dart';

class BookReviewListScreen extends StatefulWidget {
  static const String id = 'book_review_list';

  final String title;
  final String image;
  final String author;

  BookReviewListScreen(
      {required this.title, required this.image, required this.author});

  @override
  State<BookReviewListScreen> createState() => _BookReviewListScreenState();
}

class _BookReviewListScreenState extends State<BookReviewListScreen> {
  String selectedTab = '기록';
  final List<String> options = ['최신순', '오래된순'];
  String dropdownValue = '최신순';

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;

    final bool isChecked = false;

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: bodyHeight * (56 / kDeviceHeight),
            width: bodyWidth,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.chevron_left,
                    color: Color(0xff303030).withAlpha((0.4 * 255).round()),
                    size: bodyWidth * (24 / kDeviceWidth),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                // Text('독후감 작성', style: kTextStyle16(context))
              ],
            ),
          ),
          Container(
            height: bodyHeight * (72 / kDeviceHeight),
            child: BookItem(widget.title, widget.image, widget.author),
          ),
          Container(
            height: bodyHeight * (48 / kDeviceHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = "기록";
                    });
                  },
                  child: Container(
                    width: (bodyWidth / 2),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == '기록'
                              ? Colors.black
                              : Color(0xff303030)
                                  .withAlpha((0.4 * 255).round()), // 원하는 색상
                          width: 2.0, // 두께
                        ),
                      ),
                    ),
                    alignment: Alignment.center, // 텍스트 중앙 정렬
                    child: Text(
                      '기록',
                      style: selectedTab == "기록"
                          ? kTextStyle16(context)
                          : kTextStyle16(context, opacity: 0.4),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('정보');
                    setState(() {
                      selectedTab = '정보';
                    });
                  },
                  child: Container(
                    width: (bodyWidth / 2),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == '정보'
                              ? Colors.black
                              : Color(0xff303030)
                                  .withAlpha((0.4 * 255).round()), // 원하는 색상
                          width: 1.0, // 두께
                        ),
                      ),
                    ),
                    alignment: Alignment.center, // 텍스트 중앙 정렬
                    child: Text(
                      '정보',
                      style: selectedTab == "정보"
                          ? kTextStyle16(context)
                          : kTextStyle16(context, opacity: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          selectedTab == "기록"
              ? Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      height: bodyHeight * (52 / kDeviceHeight),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '나의 기록',
                                  style: kTextStyle14(context),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '21',
                                  style: kTextStyle14(context, opacity: 0.4),
                                ),
                              ],
                            ),
                            Container(
                              width: bodyWidth * (80 / kDeviceWidth),
                              height: bodyHeight * (32 / kDeviceHeight),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
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
                                  width: bodyWidth * (10.67 / kDeviceWidth),
                                  height: bodyWidth * (6.67 / kDeviceWidth),
                                ),
                                iconSize: 0, // set to 0 to avoid interference

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
                            )
                          ]),
                    ),
                    Container(
                        height: bodyHeight * (516 / kDeviceHeight),
                        child: ReviewList())
                  ],
                )
              : Expanded(
                  child: SingleChildScrollView(
                      // height: bodyHeight * (590 / kDeviceHeight),
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: bodyHeight * (16 / kDeviceHeight)),
                          child: Text(
                            '독서량',
                            style: kTextStyle14(context),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '독서 횟수',
                                style: kTextStyle14(context, opacity: 0.4),
                              ),
                              Text(
                                '21회',
                                style: kTextStyle14(context),
                              )
                            ]),
                        SizedBox(height: bodyHeight * (16 / kDeviceHeight)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '독서 시간',
                                style: kTextStyle14(context, opacity: 0.4),
                              ),
                              Text(
                                '3시간20분18초',
                                style: kTextStyle14(context),
                              )
                            ]),
                        SizedBox(height: bodyHeight * (16 / kDeviceHeight)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '독서 기간',
                                style: kTextStyle14(context, opacity: 0.4),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '2024.01.08 ~ ',
                                    style: kTextStyle14(context),
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(0xff56698f)
                                            .withAlpha((0.06 * 255).round()),
                                        foregroundColor: Colors.black, // 배경색
                                        minimumSize: Size(
                                            bodyWidth * (43 / kDeviceWidth),
                                            bodyHeight *
                                                (24 / kDeviceHeight)), // 너비와 높이
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        '읽는 중',
                                        style: kTextStyle12(context,
                                            weight: FontWeight.w600),
                                      ))
                                ],
                              ),
                            ]),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 8,
                            width: double.infinity,
                            color: Color(0xff56698f)
                                .withAlpha((0.04 * 255).round()),
                          ),
                        ),
                        CalendarPage()
                      ],
                    ),
                  )),
                )
        ],
      ),
    ));
  }
}
