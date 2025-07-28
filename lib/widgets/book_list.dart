import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/model/book.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';
import 'package:book_luck_app_demo/widgets/book_list_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';

const warningText = {
  ReadingStatus.wishlist: '위시리스트에 저장된 책이 없습니다. \n읽고 싶은 책을 저장해 보세요.',
  ReadingStatus.reading: '읽고 있는 책이 없습니다. \n읽고 싶은 책을 저장해 보세요.',
  ReadingStatus.finished: '다 읽은 책이 없습니다. \n읽고 싶은 책을 저장해 보세요.',
  ReadingStatus.search: '검색 결과가 없습니다. \n책 제목과 저자를 수동으로 입력해 주세요.',
};

class BookList extends StatefulWidget {
  final ReadingStatus status;
  final String? keyword; // nullable
  final void Function(int numberOfBooks)? countBooks;

  BookList(this.status, {this.keyword, this.countBooks});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<String> isFavorite = [];
  List<dynamic> _books = [];

  Future<void> getBooks() async {
    late String url;
    String loginUser = '1';
    switch (widget.status) {
      case ReadingStatus.wishlist:
        url = ApiEndpoints.userFavoritesDetails(loginUser);
        break;
      case ReadingStatus.reading:
        url = ApiEndpoints.getAllBooks; // or a specific endpoint
        break;
      case ReadingStatus.finished:
        url = ApiEndpoints.userFavoritesDetails(loginUser);
        break;
      case ReadingStatus.search:
        url = ApiEndpoints.searchBooks(widget.keyword ?? "");
        break;
    }

    NetworkHelper networkHelper = NetworkHelper(url);

    var bookData = await networkHelper.getData();
    if (bookData != null) {
      setState(() {
        _books = bookData.map((json) => Book.fromJson(json)).toList();
        if (widget.countBooks != null) {
          widget.countBooks!(_books.length);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant BookList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When parent passes a different status, refetch
    if (oldWidget.status != widget.status ||
        oldWidget.keyword != widget.keyword) {
      getBooks();
    }
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    if (_books.length == 0) {
      return Container(
        height: bodyHeight * (200 / kDeviceHeight),
        padding: EdgeInsets.symmetric(vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/warning.svg',
                  width: bodyWidth * (24 / kDeviceWidth),
                  height: bodyHeight * (24 / kDeviceHeight),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  warningText[widget.status] ?? "",
                  textAlign: TextAlign.center,
                  style: kTextStyle14(context,
                      weight: FontWeight.w500, opacity: 0.5),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Color(0xff56698f).withAlpha((0.06 * 255).round()),
                  foregroundColor: Colors.black, // 배경색
                  minimumSize: Size(bodyWidth * (102 / kDeviceWidth),
                      bodyHeight * (32 / kDeviceHeight)), // 너비와 높이
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '지금 읽으러 가기',
                  style: kTextStyle12(context),
                )),
            Spacer()
          ],
        ),
      );
    }

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          final book = _books[index];
          return BookListItem(book.title, book.image, book.isbn, book.author,
              book.description, book.favorite, widget.status);
        });
  }
}
