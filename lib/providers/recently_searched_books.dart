import 'package:book_luck_app_demo/model/book.dart';
import 'package:flutter/material.dart';

class RecentlySearchedBooksProvider extends ChangeNotifier {
  List<Book> _recentlySearchedBooks = [];

  Book operator [](int index) => _recentlySearchedBooks[index];

  void addRecentlySearchedBooks(Book b) {
    _recentlySearchedBooks.add(b);
    print("최근 검색 책 추가");
    print(_recentlySearchedBooks);
    notifyListeners();
  }

  int numberOfRecentlySearchedBooks() {
    return _recentlySearchedBooks.length;
  }

  List<Book> getRecentlySearchedBooks() {
    return _recentlySearchedBooks;
  }
}
