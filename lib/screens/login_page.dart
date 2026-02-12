import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the '/home' screen when the screen is tapped
        Navigator.pushNamed(context, HomeScreen.id);
      },
      child: Scaffold(
        body: Column(
          children: [
            Spacer(), // Pushes the content below to the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFEE601),
                  fixedSize: Size(320, 56),
                  minimumSize: Size(double.infinity, 50),
                ).copyWith(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                onPressed: () {
                  // Action for Button 1
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/kakao.svg', // Replace with your Kakao logo asset path
                      height: 24, // Adjust height to fit button
                      width: 24,
                    ),
                    SizedBox(
                      height: 24,
                      width: 4,
                    ), // Space between logo and text
                    Text(
                      "카카오로 시작하기",
                      style: TextStyle(
                          color: Color(0xFF3B1E1E), // Text color
                          fontSize: 16,
                          fontFamily: "SUIT Variable"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF000000), // Black color
                  fixedSize: Size(320, 56),
                  minimumSize: Size(double.infinity, 50),
                ).copyWith(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                onPressed: () {
                  // Action for Button 2
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/apple.svg', // Replace with your Apple logo asset path
                      height: 24, // Adjust height to fit button
                      width: 24,
                    ),
                    SizedBox(
                      height: 24,
                      width: 4,
                    ), // Space between logo and text
                    Text(
                      "Apple로 시작하기",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(86, 105, 143, 0.06),
                  foregroundColor: Color.fromRGBO(86, 105, 143, 0.06),
                  elevation: 0, // Remove shadow
                  fixedSize: Size(320, 56),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(8)), // Rounded corners
                  ),
                ),
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const GoogleLoginWebView()),
                //   );
                // },
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(
                        "https://api.bookluck.org/oauth2/authorization/google"),
                    mode: LaunchMode.externalApplication,
                  );
                },

                child: Text(
                  "Google로 시작하기",
                  style: TextStyle(
                    color: Color(0xFF303030), // Text color
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  // Transparent background
                  elevation: 0, // Remove shadow
                  fixedSize: Size(320, 56),
                  minimumSize: Size(double.infinity, 50),
                ).copyWith(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  side: WidgetStateProperty.all(BorderSide.none),
                ),
                onPressed: () {
                  // Action for Button 4
                },
                child: Text(
                  "이메일로 회원가입하기",
                  style: TextStyle(
                    color: Color.fromRGBO(48, 48, 48, 0.6), // Text color
                    fontSize: 14, // Font size
                    decoration: TextDecoration.underline, // Underline the text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
