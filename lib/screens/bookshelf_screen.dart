import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app/widgets/BookListContainer.dart';

class BookshelfScreen extends StatefulWidget {
  @override
  _BookshelfScreenState createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  String selectedCategory = "전체";
  String selectedText = '위시리스트';

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        // MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final bodyWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left - // Exclude SafeArea left padding
        MediaQuery.of(context).padding.right; // Exclude SafeArea right padding

    List<String> categories = ["전체", "소설", "인문학", "에세이", "과학", "철학"];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container 1 with specific height
                Container(
                  height: 0.0790 * bodyHeight, // 15% of the screen height
                  // color: Colors
                  //     .red, // Just for visualization, you can change this to any color
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.0556 * bodyWidth, // Left and right padding
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Vertically center content

                      children: [
                        Text(
                          '책장',
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontFamily: 'SUITVariable',
                            fontSize: 0.0444 * bodyWidth, // Text size
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            letterSpacing: -0.32,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/search.svg', // Replace with your actual image path
                          // height: 0.0268 * bodyHeight,
                          width: 0.0528 * bodyWidth,
                          // Adjust image height based on your needs
                        ),
                      ],
                    ),
                  ),
                ),

                // Container 2 with specific height
                Container(
                    height: 0.0677 * bodyHeight, // 10% of the screen height
                    // color: Colors.blue,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              0.0708 * bodyWidth, // Left and right padding
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between items
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Vertically center content
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedText = '위시리스트';
                                });
                              },
                              child: Container(
                                height: 0.0677 * bodyHeight,
                                child: Text(
                                  "위시리스트",
                                  style: TextStyle(
                                    color: selectedText == "위시리스트"
                                        ? Color(0xFF303030)
                                        : Color(0xFF303030).withOpacity(0.4),
                                    fontFamily: 'SUITVariable',
                                    fontSize: 0.0444 * bodyWidth, // Text size
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    letterSpacing: -0.32,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                setState(() {
                                  selectedText = '읽는 중';
                                })
                              },
                              child: Container(
                                height: 0.0677 * bodyHeight,
                                child: Text(
                                  "읽는 중",
                                  style: TextStyle(
                                    color: selectedText == "읽는 중"
                                        ? Color(0xFF303030)
                                        : Color(0xFF303030).withOpacity(0.4),
                                    fontFamily: 'SUITVariable',
                                    fontSize: 0.0444 * bodyWidth, // Text size
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    letterSpacing: -0.32,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedText = "다 읽은 책";
                                });
                              },
                              child: Container(
                                height: 0.0677 * bodyHeight,
                                child: Text(
                                  "다 읽은 책",
                                  style: TextStyle(
                                    color: selectedText == '다 읽은 책'
                                        ? Color(0xFF303030)
                                        : Color(0xFF303030).withOpacity(0.4),
                                    fontFamily: 'SUITVariable',
                                    fontSize: 0.0444 * bodyWidth, // Text size
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    letterSpacing: -0.32,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),

                // Container 3 with specific height
                Container(
                    height: 0.0846 * bodyHeight, // 12% of the screen height
                    // color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            0.0708 * bodyWidth, // Left and right padding
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between items
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: categories
                              .map<Widget>((category) => Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0), // Spacing between buttons
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          // Select the clicked category and deselect the previous one
                                          selectedCategory = category;
                                        });
                                      }, // Add your action here
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0222 * bodyWidth),
                                          // Rounded edges
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.0222 * bodyWidth,
                                            vertical: 0.0099 * bodyHeight),
                                        side: BorderSide(
                                          color: selectedCategory == category
                                              ? Colors
                                                  .transparent // No border if selected
                                              : Color.fromRGBO(48, 48, 48,
                                                  0.08), // Border color
                                          width: 1, // Border width
                                        ),
                                        backgroundColor: selectedCategory ==
                                                category
                                            ? Color(
                                                0xFF303030) // Background color when selected
                                            : Colors
                                                .transparent, // Default background color
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: selectedCategory == category
                                              ? Colors
                                                  .white // Text color when selected
                                              : Color(
                                                  0xFF303030), // Default text color
                                          fontFamily: 'SUITVariable',
                                          fontSize:
                                              0.0333 * bodyWidth, // Text size
                                          fontWeight: FontWeight.w700,
                                          height: 1.5,
                                          letterSpacing: -0.32,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(), // ✅ Fix: Convert Iterable to List<Widget>,
                        ),
                      ),
                    )),

                // Container 4 with specific height
                Container(
                    height: 0.0733 * bodyHeight, // 8% of the screen height
                    // color: Colors.orange,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.0556 * bodyWidth,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Space between items
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            selectedCategory.isNotEmpty
                                ? selectedCategory
                                : '전체 10',
                            style: TextStyle(
                              color: Color(0xFF303030),
                              fontSize: 0.0389 * bodyWidth,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SUITVariable',
                              height: 1.5,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    )),

                // Container 5 with specific height
                BookListContainer(),

                // You can also add other widgets inside these containers, such as buttons, images, etc.
              ],
            ),
          ),
        ),
      ],
    );
  }
}
