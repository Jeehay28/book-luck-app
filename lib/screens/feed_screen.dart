import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app/utils/mockData.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top // Exclude SafeArea top padding
        -
        MediaQuery.of(context)
            .padding
            .bottom; // Exclude SafeArea bottom padding

    final bodyWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left - // Exclude SafeArea left padding
        MediaQuery.of(context).padding.right; // Exclude SafeArea right padding

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 표지
                Container(
                  height: bodyHeight * 0.0790,
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0556 * bodyWidth),
                    child: Text(
                      "피드",
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontFamily: 'SUITVariable',
                        fontSize: 0.0444 * bodyWidth, // Text size
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ),
                ),
                // Use the mock data for the books
                ...mockFeedBooks.map((book) {
                  int index = mockFeedBooks.indexOf(book);

                  // Check if the current book is the last one in the list
                  bool isLastItem = index == mockFeedBooks.length - 1;

                  return Container(
                    height: bodyHeight * 0.3075,
                    child: Column(
                      children: [
                        // 책 표지, 제목, 저자
                        Container(
                          height: bodyHeight * 0.0790,
                          // color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0556 * bodyWidth),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: bodyWidth * 0.7778,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: bodyWidth * 0.1111,
                                        height: bodyHeight * 0.0564,
                                        child: Center(
                                          child: Image.asset(
                                            book['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: bodyWidth * 0.6333,
                                        height: bodyHeight * 0.0592,
                                        // color: Colors.blue,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: bodyHeight * 0.033,
                                              child: Text(
                                                book['title'],
                                                style: TextStyle(
                                                  color: Color(0xFF303030),
                                                  fontFamily: 'SUITVariable',
                                                  fontSize: 0.0444 * bodyWidth,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5,
                                                  letterSpacing: -0.32,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: bodyHeight * 0.025,
                                                child: Text(
                                                  book['author'],
                                                  style: TextStyle(
                                                    color: Color(0xFF303030)
                                                        .withOpacity(0.4),
                                                    fontFamily: 'SUITVariable',
                                                    fontSize:
                                                        0.0333 * bodyWidth,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5,
                                                    letterSpacing: -0.32,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: bodyWidth * 0.0556,
                                  child: Center(
                                    child: SvgPicture.asset(
                                        'assets/images/dots.svg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 책 요약 및 기타 정보
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0556 * bodyWidth,
                              vertical: bodyHeight * 0.0225),
                          child: Container(
                            height: bodyHeight * 0.1834,
                            // color: Colors.green,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: bodyHeight * 0.1410,
                                  child: Text(
                                    book['summary'],
                                    style: TextStyle(
                                      color: Color(0xFF303030),
                                      fontFamily: 'SUITVariable',
                                      fontSize: 0.034 * bodyWidth,
                                      fontWeight: FontWeight.w400,
                                      height: 1.66,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: bodyHeight * 0.0254,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        book['date'],
                                        style: TextStyle(
                                          color: Color(0xFF303030)
                                              .withOpacity(0.4),
                                          fontFamily: 'SUITVariable',
                                          fontSize: 0.0333 * bodyWidth,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          letterSpacing: -0.32,
                                        ),
                                      ),
                                      Text(
                                        book['readingTime'],
                                        style: TextStyle(
                                          color: Color(0xFF303030)
                                              .withOpacity(0.4),
                                          fontFamily: 'SUITVariable',
                                          fontSize: 0.0333 * bodyWidth,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          letterSpacing: -0.32,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isLastItem)
                                  Divider(
                                    color: Color(0xFF303030)
                                        .withOpacity(0.06), // Line color
                                    height:
                                        0.0014 * bodyHeight, // Line thickness
                                    indent:
                                        0, // Horizontal space before the line
                                    endIndent:
                                        0, // Horizontal space after the line
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
