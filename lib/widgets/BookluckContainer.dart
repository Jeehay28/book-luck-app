import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Flexible(
                  child: Container(
                      // height: 34,
                      height: 0.0480 * bodyHeight,
                      width: 0.3139 * bodyWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment
                        //     .start, // Optional: Center contents horizontally
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Optional: Center contents vertically
                        children: [
                          SvgPicture.asset(
                            'assets/images/bookluck.svg',
                            width: 0.0444 * bodyWidth,
                            height: 0.0226 * bodyHeight,
                          ),
                          Text(
                            "BOOKLUCK",
                            style: TextStyle(
                              fontFamily: 'DOSIyagiBoldface',
                              // fontSize: 0.005 * bodyWidth, // Adjust font size as needed
                              fontWeight: FontWeight.normal, // Optional styling
                            ),
                          ),
                        ],
                      ))),
              // SizedBox(width: 0.4556 * bodyWidth),
              Flexible(
                  child: Container(
                // width: 43,
                width: 0.1194 * bodyWidth,
                height: 0.0480 * bodyHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/mail.svg',
                      // fit: BoxFit.contain,
                      // // width: 24,
                      width: 0.0667 * bodyWidth,
                      height: 0.0240 * bodyHeight,
                      // color: const Color(0xFFFBD115),
                    ),
                    // SizedBox(width: 0.0194 * bodyWidth), //7
                    Text(
                      '1',
                      style: TextStyle(
                        color: const Color(0xFF303030),
                        fontSize: 0.0667 * bodyWidth,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
