import 'package:flutter/material.dart';

class QuoteContainer extends StatelessWidget {
  final double heightFactor;

  const QuoteContainer({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
        height: screenHeight * 0.1721, // 17.21% of screen height, 122,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 1, // Border width
          ),
          color: Colors.transparent, // Transparent background
          borderRadius:
              BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,

            fixedSize: Size(320, 240),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                    color: Color.fromRGBO(48, 48, 48, 0.12), width: 1)),
            elevation:
                0, // Remove shadow to mimic semi-transparent background better
          ),
          onPressed: () {},
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize space between items
              children: [
                Image.asset(
                  'assets/images/warning.png', // Replace with your image path
                  width: 24, // Set the width of the image
                  height: 24, // Set the height of the image
                  fit: BoxFit.contain, // Adjust image fit if needed
                ),
                Text(
                  '업데이트된 명언이 없습니다. \n업데이트 전까지 조그만 기다려주세요!',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 48, 48, 0.6),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
