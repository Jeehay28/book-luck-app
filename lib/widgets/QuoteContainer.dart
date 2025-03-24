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
        print("Quote Success!");
        // print(jsonDecode(response.body));
        print(jsonDecode(utf8.decode(response.bodyBytes)));

        setState(() {
          _quotes = jsonDecode(utf8.decode(response.bodyBytes));
        });

        // return json.decode(response.body);

        // return json.decode(response.body);
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

      // Fetch new quote periodically
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
      height: 0.1721 * widget.bodyHeight,
      // width: 0.8889 * widget.bodyWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          fixedSize: Size(0.911 * widget.bodyWidth, 0.1467 * widget.bodyHeight),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(
                  color: Color.fromRGBO(48, 48, 48, 0.12), width: 1)),
          elevation: 0,
        ),
        onPressed: () {
          // Call _fetchDataAndNavigate when the button is pressed
          _fetchDataAndNavigate(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.bodyHeight * 0.0226,
              horizontal:
                  widget.bodyWidth * 0.0556), // Adjust padding as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   'assets/images/warning.svg',
              //   width: 0.0667 * widget.bodyWidth,
              //   height: 0.0339 * widget.bodyHeight,
              //   // fit: BoxFit.contain,
              // ),
              // Carousel Text using PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _quotes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 0.1016 * widget.bodyHeight,
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
                            SizedBox(height: widget.bodyHeight * 0.0113),
                            Text(
                              _quotes['name'] ??
                                  'Unknown author', // Access the 'name' key
                              style: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 0)
                                    .withOpacity(0.6),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
