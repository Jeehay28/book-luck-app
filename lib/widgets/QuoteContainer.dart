import 'package:flutter/material.dart';

class QuoteContainer extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const QuoteContainer({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.1721 * bodyHeight,
        width: 0.8889 * bodyWidth, // 17.21% of screen height, 122,
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

            fixedSize: Size(0.7778 * bodyWidth, 0.1326 * bodyHeight),
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
                  width: 0.0667 * bodyWidth, // Set the width of the image
                  height: 0.0339 * bodyHeight, // Set the height of the image
                  fit: BoxFit.contain, // Adjust image fit if needed
                ),
                Text(
                  '업데이트된 명언이 없습니다. \n업데이트 전까지 조금금만 기다려주세요!',
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
