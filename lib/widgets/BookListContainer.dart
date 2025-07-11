import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookListContainer extends StatefulWidget {
  @override
  _BookListContainerState createState() => _BookListContainerState();
}

class _BookListContainerState extends State<BookListContainer> {
  // Mock Data List (Later, you can replace this with data from the server)

  String findBooksURI = "http://43.202.122.137/books/getAllBooks";
  String addToFavoriteURI = "http://43.202.122.137/books/addToFavorites";
  List<String> isFavorite = [];
  List<dynamic> _books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse(findBooksURI),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> fetchedBooks =
            jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _books = fetchedBooks;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> addToFavorite(String userId, String bookId) async {
    try {
      print("addToFavorite....");
      print('$userId $bookId');
      final response = await http.post(Uri.parse(addToFavoriteURI),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode({
            'userId': userId,
            'bookId': bookId,
          }));

      if (response.statusCode == 200) {
        print("added to favorite...");
        setState(() {
          isFavorite.add(bookId);
        });
      } else {
        print("Failed to add to favorite. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

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
      children: _books.map((book) {
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
                    child: Image.network(
                  book["image"] ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image),
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
                      child: Text(book["title"] ?? "No Title",
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 0.0444 * bodyWidth,
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'SUITVariable',
                            height: 1.5,
                            letterSpacing: -0.32,
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.0254 * bodyHeight,
                      child: Text(
                        book["author"]?.toString().isNotEmpty == true
                            ? book["author"]
                            : "Unknown Author",
                        style: TextStyle(
                          color: Color(0xFF303030).withOpacity(0.4),
                          fontSize: 0.0333 * bodyWidth,
                          fontWeight: FontWeight.w700,
                          // fontFamily: 'SUITVariable',
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
              GestureDetector(
                onTap: () async {
                  print(book);
                  print("GestureDetector Clicked....");
                  await addToFavorite("1", book['isbn'].toString());
                },
                child: Container(
                  width: 0.0667 * bodyWidth,
                  height: 0.0339 * bodyHeight,
                  child: Center(
                      child: SvgPicture.asset(isFavorite.contains(book['isbn'])
                          ? 'assets/images/heart.svg'
                          : 'assets/images/grey_heart.svg')),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
