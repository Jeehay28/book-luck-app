import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/widgets/book_list.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/styles/app_button_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';
import 'package:book_luck_app_demo/screens/book_search_screen.dart';

class BookshelfScreen extends StatefulWidget {
  static const String id = 'bookshelf';

  @override
  _BookshelfScreenState createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  String selectedCategory = "전체";
  String selectedReadingStatus = '위시리스트';
  int numberOfBooks = 0;

  void countBooks(int searchResult) {
    setState(() {
      numberOfBooks = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    var categories = kCategories;
    var readingStatus = kReadingStatus;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 책장
        Container(
            height: bodyHeight * (56 / kDeviceHeight),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('책장', style: kTextStyle16(context)),
                GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () {
                    Navigator.pushNamed(context, BookSearchScreen.id);
                  },
                )
              ],
            )),
        // 위시리스트 + 읽는 중 + 다 읽은 책
        Container(
            height: bodyHeight * (48 / kDeviceHeight),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: readingStatus
                  .map((status) => TextButton(
                      onPressed: () {
                        setState(() {
                          selectedReadingStatus = status;
                        });
                      },
                      child: Text(
                        status,
                        style: selectedReadingStatus == status
                            ? kTextStyle16(
                                context,
                              )
                            : kTextStyle16(context, opacity: 0.2),
                      )))
                  .toList(),
            )),

        // 카테고리: 전체, 소설, 인문학, ...
        Container(
          height: bodyHeight * (60 / kDeviceHeight),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          // color: Colors.pink,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 🔑 make it scroll sideways
            child: Row(
              children: categories
                  .map((category) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            style: category == selectedCategory
                                ? kButtonActive
                                : kButtonInactive,
                            child: Text(
                              category,
                              style: category == selectedCategory
                                  ? kTextStyle12(context, color: Colors.white)
                                  : kTextStyle12(context),
                            )),
                      ))
                  .toList(),
            ),
          ),
        ),

        // 전체(카테고리) +  10(카운트)
        Container(
            height: bodyHeight * (52 / kDeviceHeight),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  selectedCategory,
                  style: kTextStyle16(context),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  numberOfBooks.toString(),
                  style: kTextStyle14(context, opacity: 0.4),
                )
              ],
            )),
        Expanded(
            child: BookList(
          ReadingStatusExtension.from(selectedReadingStatus),
          countBooks: countBooks,
        )),
      ],
    );
  }
}
