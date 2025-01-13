import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "bigText1": "서비스 설명이 ",
      "bigText2": "들어가는 영역입니다.",
      "middleText1": "디스크립션이 들어가는 영역입니다.",
      "middleText2": "두 줄정도 들어가면 좋습니다.",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "기록에 관한 내용이",
      "bigText2": "들어가는 영역입니다.",
      "middleText1": "디스크립션이 들어가는 영역입니다.",
      "middleText2": "두 줄정도 들어가면 좋습니다.",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "타유저 인사이트 내용이",
      "bigText2": "들어가는 영역입니다.",
      "middleText1": "디스크립션이 들어가는 영역입니다.",
      "middleText2": "두 줄정도 들어가면 좋습니다.",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "(뱃지, 레벨업) 성취감 내용이 ",
      "bigText2": "들어가는 영역입니다.",
      "middleText1": "디스크립션이 들어가는 영역입니다.",
      "middleText2": "두 줄정도 들어가면 좋습니다.",
      "logo": "assets/images/logo.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Display big text fields
                      Text(
                        data["bigText1"]!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data["bigText2"]!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Display middle text fields
                      Text(
                        data["middleText1"]!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        data["middleText2"]!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 30), // Add spacing between text and logo
                      // Display the logo after the text
                      SvgPicture.asset(
                        data["logo"]!,
                        height: 150,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Pagination dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => buildDot(index, context),
            ),
          ),
          SizedBox(height: 30),
          // Navigation button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ).copyWith(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
                ),
              ),
              onPressed: () {
                if (_currentPage == _onboardingData.length - 1) {
                  // Navigate to the next page (e.g., Login Page)
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(
                _currentPage == _onboardingData.length - 1
                    ? "바로 시작하기"
                    : "바로 시작하기",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the dot indicators for the PageView
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      // width: _currentPage == index ? 20 : 10,
      width: 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
