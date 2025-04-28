import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookListContainer extends StatefulWidget {
  @override
  _BookListContainerState createState() => _BookListContainerState();
}

class _BookListContainerState extends State<BookListContainer> {
  // Mock Data List (Later, you can replace this with data from the server)
  final List<Map<String, String>> books = [
    {
      "image": "assets/images/sample-book-01.jpg",
      "title": "천개의 파랑",
      "author": "천선란",
    },
    {
      "image": "assets/images/sample-book-02.jpg",
      "title": "부분과 전체",
      "author": "베르너 하이젠베르크",
    },
    {
      "image": "assets/images/sample-book-03.jpg",
      "title": "구의 증명",
      "author": "최진영",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
    {
      "image": "assets/images/sample-book-00.jpg",
      "title": "책제목이 들어갑니다",
      "author": "저자 이름이 들어갑니다",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        // MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final bodyWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left - // Exclude SafeArea left padding
        MediaQuery.of(context).padding.right; // Exclude SafeArea right padding

    return Column(
      children: books.map((book) {
        return Container(
          height: 0.1016 * bodyHeight,
          padding: EdgeInsets.symmetric(horizontal: 0.0556 * bodyWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Book Image
              Container(
                width: 0.1111 * bodyWidth,
                height: 0.0790 * bodyHeight,
                child: Center(
                    child: Image.asset(
                  book["image"]!,
                  fit: BoxFit.cover,
                )),
              ),
              // Book Title & Author
              Container(
                width: 0.5444 * bodyWidth,
                height: 0.0790 * bodyHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.0339 * bodyHeight,
                      child: Text(book["title"]!,
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 0.0444 * bodyWidth,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SUITVariable',
                            height: 1.5,
                            letterSpacing: -0.32,
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.0254 * bodyHeight,
                      child: Text(
                        book["author"]!,
                        style: TextStyle(
                          color: Color(0xFF303030).withOpacity(0.4),
                          fontSize: 0.0333 * bodyWidth,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SUITVariable',
                          height: 1.5,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Dots & Heart Icons
              Container(
                width: 0.0556 * bodyWidth,
                height: 0.0282 * bodyHeight,
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/dots.svg',
                )),
              ),
              Container(
                width: 0.0667 * bodyWidth,
                height: 0.0339 * bodyHeight,
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/heart.svg',
                )),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
