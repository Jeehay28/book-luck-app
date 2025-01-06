import 'package:flutter/material.dart';

class BookluckContainer extends StatelessWidget {
  // final double heightFactor;
  final double bodyHeight;
  final double bodyWidth;

  const BookluckContainer(
      {Key? key, required this.bodyHeight, required this.bodyWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // height: screenHeight * heightFactor, // 8.18% of screen height
      height: 0.0818 * bodyHeight,
      width: bodyWidth,

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Center(
        child: Container(
          width: 0.8889 * bodyWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(width: (bodyWidth * 0.0556)),
              Container(
                // height: 34,
                height: 0.480 * bodyHeight,
                width: 0.2583 * bodyWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Image.asset(
                  'assets/images/bookluck.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 0.4556 * bodyWidth),
              Container(
                // width: 43,
                width: 0.1194 * bodyWidth,
                height: 0.480 * bodyHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/mail.png',
                      fit: BoxFit.contain,
                      // width: 24,
                      width: 0.0667 * bodyWidth,
                    ),
                    SizedBox(width: 0.0194 * bodyWidth),
                    const Text(
                      '1',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
