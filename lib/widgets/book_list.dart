import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/model/book.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';

class BookList extends StatefulWidget {
  final ReadingStatus status;
  final String? keyword; // nullable

  BookList(this.status, {this.keyword});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<String> isFavorite = [];
  List<dynamic> _books = [];

  Future<void> getBooks() async {
    late String url;
    print(widget.status);
    switch (widget.status) {
      case ReadingStatus.wishlist:
        url = ApiEndpoints.userFavoritesDetails('1');
        break;
      case ReadingStatus.reading:
        url = ApiEndpoints.getAllBooks; // or a specific endpoint
        break;
      case ReadingStatus.finished:
        url = ApiEndpoints.userFavoritesDetails('1');
        break;
      case ReadingStatus.search:
        url = ApiEndpoints.searchBooks(widget.keyword ?? "");
        break;
    }

    NetworkHelper networkHelper = NetworkHelper(url);

    print(url);

    var bookData = await networkHelper.getData();
    print("bookData*********");
    print(bookData);
    if (bookData != null) {
      setState(() {
        _books = bookData.map((json) => Book.fromJson(json)).toList();
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
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          final book = _books[index];
          return BookItem(book.title, book.image, book.isbn, book.author,
              book.favorite, widget.status);
        });
  }
}

class BookItem extends StatefulWidget {
  final String title;
  final String image;
  final String isbn;
  final String author;
  final bool favorite;
  final ReadingStatus status;

  BookItem(this.title, this.image, this.isbn, this.author, this.favorite,
      this.status);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  late bool heart;

  @override
  void initState() {
    super.initState();
    heart = widget.favorite; // initialize once
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    Future<void> addToFavorite(String userId, String bookId) async {
      if (!heart) {
        try {
          NetworkHelper networkHelper =
              NetworkHelper(ApiEndpoints.addToFavorites, body: {
            'userId': userId,
            'bookId': bookId,
          });

          var result = await networkHelper.postData();

          if (result != null) {
            print(result);
            setState(() {
              heart = true;
            });
          }
        } catch (err) {
          print('Error during addToFavorite: $err');
        }
      }
    }

    Future<void> deleteFromFavorite(String userId, String bookId) async {
      if (heart == true) {
        try {
          NetworkHelper networkHelper = NetworkHelper(
              ApiEndpoints.deleteBookFromWishlist(userId, bookId));

          var result = await networkHelper.deleteData();
          print(result);

          if (result != null) {
            print(result);
            setState(() {
              heart = false;
            });
          }
        } catch (err) {
          print('Error during addToFavorite: $err');
        }
      }
    }

    return Container(
        height: bodyHeight * (72 / kDeviceHeight),
        width: 360,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                width: bodyWidth * (40 / kDeviceWidth),
                height: bodyHeight * (56 / kDeviceHeight),
              ),
              SizedBox(
                width: bodyWidth * (196 / kDeviceWidth),
                height: bodyHeight * (46 / kDeviceHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: kTextStyle16(context),
                    ),
                    Text(
                      widget.author,
                      overflow: TextOverflow.ellipsis,
                      style: kTextStyle12(context,
                          opacity: 0.4, weight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Icon(Icons.more_horiz),
              if (widget.status == ReadingStatus.wishlist)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.favorite_border,
                        color: Colors.black,
                        size: bodyWidth * (28 / kDeviceWidth)),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: bodyWidth * (24 / kDeviceWidth),
                    )
                  ],
                ),
              if (widget.status == ReadingStatus.search)
                GestureDetector(
                  child: Stack(alignment: Alignment.center, children: [
                    Icon(
                      Icons.favorite,
                      color: heart
                          ? Colors.red
                          : Color(0xff303030).withAlpha((0.12 * 255).round()),
                      size: bodyWidth * (24 / kDeviceWidth),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: heart
                          ? Colors.red
                          : Color(0xff303030).withAlpha((0.5 * 255).round()),
                      size: bodyWidth * (24 / kDeviceWidth),
                    ),
                  ]),
                  onTap: () {
                    addToFavorite('1', widget.isbn);
                  },
                ),
              if (widget.status == ReadingStatus.search)
                GestureDetector(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.highlight_off,
                        color: Color(0xff303030).withAlpha((0.5 * 255).round()),
                        size: bodyWidth * (24 / kDeviceWidth),
                      ),
                    ],
                  ),
                  onTap: () {
                    deleteFromFavorite('1', widget.isbn);
                    print(widget.isbn);
                  },
                ),
            ]));
  }
}
