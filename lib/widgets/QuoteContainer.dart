import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'package:http/http.dart' as http;

class QuoteContainer extends StatefulWidget {
  final double bodyHeight;
  final double bodyWidth;

  const QuoteContainer({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  _QuoteContainerState createState() => _QuoteContainerState();
}

class _QuoteContainerState extends State<QuoteContainer> {
  late PageController _pageController;
  int _currentIndex = 0; // Current page index
  Map<String, dynamic> _quotes = {
    "id": 12,
    "phrase": "업데이트된 명언이 없습니다.",
    "name": "업데이트 전까지 조금만 기다려주세요!"
  };

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchBooks();
    _pageController = PageController(initialPage: _currentIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });

    // Set up a timer to change the text every 3 seconds (for carousel effect)
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   if (_currentIndex < _quotes.length - 1) {
    //     _currentIndex++;
    //   } else {
    //     _currentIndex = 0;
    //   }
    //   _pageController.animateToPage(_currentIndex,
    //       duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    // });
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('http://43.202.122.137:8080/phrases/getRandomPhrase'),
        // Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _quotes = jsonDecode(utf8.decode(response.bodyBytes));
          //
          // String phrase = _quotes['phrase'];
          // String name = _quotes['name'];
          //
          // // 46자 초과 시 잘라냄
          // if (phrase.length > 40) {
          //   phrase = phrase.substring(0, 45);
          // }
          //
          // if (name.length > 20) {
          //   name = name.substring(0, 23);
          // }
          // _quotes['phrase'] = phrase;
          // _quotes['name'] = name;
          //
          // print(_quotes);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data');
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      if (!mounted) return;
      await fetchBooks();

      setState(() {
        _currentIndex = (_currentIndex + 1) % _quotes.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer
    _pageController.dispose(); // Dispose of the controller
    super.dispose();
  }

  // This method will be called when the login button is pressed
  Future<void> _fetchDataAndNavigate(BuildContext context) async {
    // Your data fetching logic here
    try {
      // Simulate a fetch operation
      await Future.delayed(Duration(seconds: 2));

      // After fetching, you could navigate or show a success message
      print('Data fetched');
    } catch (error) {
      // Handle any errors here
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.15 * widget.bodyHeight,
      width: 0.8889 * widget.bodyWidth,
      decoration: BoxDecoration(
        border: Border.all(
          // color: Colors.transparent,
          width: 1,
          color: Color(0x1F303030),
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 0.1012 * widget.bodyHeight,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _quotes['phrase'] ??
                        'No phrase available', // Access the 'phrase' key
                    style: TextStyle(
                      color: Color.fromRGBO(48, 48, 48, 1),
                      fontSize: 0.0444 * widget.bodyWidth,
                      // fontSize: 0.0244 * widget.bodyWidth,
                      fontFamily: 'MabinogiClassic',
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.0009 * widget.bodyWidth,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: widget.bodyHeight * 0.011),
                  Text(
                    _quotes['name'] ??
                        'Unknown author', // Access the 'name' key
                    style: TextStyle(
                      color: Color.fromRGBO(48, 48, 48, 0.6),
                      fontSize: 0.0389 * widget.bodyWidth,
                      fontFamily: 'MabinogiClassic',
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.0008 * widget.bodyWidth,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
