import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

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
  final List<List<String>> _quotes = [
    ['업데이트된 명언이 없습니다. \n업데이트 전까지 조금만 기다려주세요!', ""],
    ['책이란 넓디넓은 시간의 바다를 \n지나가는 배이다.', "프랜시스 베이컨"],
    ['책이란 넓디넓은 시간의 바다를 \n지나가는 배이다.', "프랜시스 베이컨"],
    ['책이란 넓디넓은 시간의 바다를 \n지나가는 배이다.', "프랜시스 베이컨"],
    ['책이란 넓디넓은 시간의 바다를 \n지나가는 배이다.', "프랜시스 베이컨"],
    ['모든 것은 시도하는 것에서 시작된다.', "프랜시스 베이컨"],
    ['도전이 없으면 변화도 없다.', "프랜시스 베이컨"]
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
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

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) return;
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
                              _quotes[index][0],
                              style: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 1),
                                fontSize: 0.0444 * widget.bodyWidth,
                                fontFamily: 'MabinogiClassic',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.0009 * widget.bodyWidth,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: widget.bodyHeight * 0.0113),
                            Text(
                              _quotes[index][1],
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
