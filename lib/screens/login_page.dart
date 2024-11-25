import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var styleFrom = ElevatedButton.styleFrom(
    //   elevation: 0,
    //   backgroundColor: Color.fromRGBO(86, 105, 143, 0.06),
    //   fixedSize: Size(320, 56),
    //   minimumSize: Size(double.infinity, 50),
    // );
    return GestureDetector(
      onTap: () {
        // Navigate to the '/home' screen when the screen is tapped
        Navigator.pushNamed(context, '/home');
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
                    Image.asset(
                      'assets/images/kakao.png', // Replace with your Kakao logo asset path
                      height: 24, // Adjust height to fit button
                    ),
                    SizedBox(height: 24), // Space between logo and text
                    Text(
                      "카카오로 시작하기",
                      style: TextStyle(
                        color: Color(0xFF3B1E1E), // Text color
                        fontSize: 18,
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
                    Image.asset(
                      'assets/images/apple.png', // Replace with your Apple logo asset path
                      height: 24, // Adjust height to fit button
                    ),
                    SizedBox(height: 24), // Space between logo and text
                    Text(
                      "Apple로 시작하기",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 18,
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
                onPressed: () {
                  // Action for Button 3
                },
                child: Text(
                  "이메일로 시작하기",
                  style: TextStyle(
                    color: Color(0xFF303030), // Text color
                    fontSize: 18,
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
