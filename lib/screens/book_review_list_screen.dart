import 'package:book_luck_app_demo/widgets/review_list.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';

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

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;

    final bool isChecked = false;

    return Scaffold(
        body: SafeArea(
            child: Column(
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
        Container(
          height: 52,
        ),

        Expanded(child: ReviewList())

        // 책 정보
      ],
    )));
  }
}
