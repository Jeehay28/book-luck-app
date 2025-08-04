import 'package:book_luck_app_demo/screens/login_page.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  static const String id = 'onboarding';

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "bigText1": "Book Luck!",
      "bigText2": "행운은 책을 여는 순간부터🍀",
      "middleText1": "북럭이와 함께",
      "middleText2": "행운 가득한 도서 여정을 떠나볼까요?",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "1분의 마법,",
      "bigText2": "시작이 가장 멋진 거니까!",
      "middleText1": "1분만 읽자! 어느새 5분, 10분 금방이에요",
      "middleText2": "꾸준하면 그게 진짜 내 것!",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "행운을 모으는",
      "bigText2": "독서친구, 북럭이",
      "middleText1": "매일 읽고 기록할수록,",
      "middleText2": "북럭이도 점점 더 밝게 성장해요 🌱",
      "logo": "assets/images/logo.svg",
    },
    {
      "bigText1": "환영합니다! ",
      "bigText2": "북럭이의 친구가 되었어요!",
      "middleText1": "읽고, 기록하며 당신만의 책장을 만들어 보세요.",
      "middleText2": "",
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display big text fields
                      Text(data["bigText1"]!,
                          textAlign: TextAlign.left,
                          style: kTextStyle24(context)),
                      Text(data["bigText2"]!,
                          textAlign: TextAlign.left,
                          style: kTextStyle24(context)),
                      SizedBox(height: 20),
                      // Display middle text fields
                      Text(data["middleText1"]!,
                          textAlign: TextAlign.left,
                          style: kTextStyle16(context,
                              opacity: 0.6, weight: FontWeight.w500)),
                      Text(data["middleText2"]!,
                          textAlign: TextAlign.left,
                          style: kTextStyle16(context,
                              opacity: 0.6, weight: FontWeight.w500)),
                      SizedBox(height: 30), // Add spacing between text and logo
                      // Display the logo after the text
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          data["logo"]!,
                          height: 150,
                        ),
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
                  Navigator.pushNamed(context, LoginPage.id);
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
