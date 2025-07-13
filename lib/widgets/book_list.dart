import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/model/book.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';
import 'package:book_luck_app_demo/widgets/book_list_item.dart';

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
          return BookListItem(book.title, book.image, book.isbn, book.author,
              book.favorite, widget.status);
        });
  }
}
