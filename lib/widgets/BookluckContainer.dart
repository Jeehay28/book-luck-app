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
              // left section
              Flexible(
                  child: Container(
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
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Optional: Center contents vertically
                        children: [
                          SvgPicture.asset(
                            'assets/images/bookluck.svg',
                            width: 0.0444 * bodyWidth,
                          ),
                          SizedBox(
                            width: 0.011 * bodyWidth,
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/images/bookluck_text.svg',
                              width: double
                                  .infinity, // This ensures the text takes up all remaining space
                            ),
                          ),
                        ],
                      ))),

              // right section
              Flexible(
                child: Container(
                  // width: 0.1194 * bodyWidth,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/mail.svg',
                        width: 0.0667 * bodyWidth,
                      ),
                      SizedBox(
                        width: 0.0194 * bodyWidth,
                      ),
                      Flexible(
                        child: Text(
                          "2", // You can dynamically change this text
                          style: TextStyle(
                            fontFamily: 'DOSIyagiBoldface',
                            fontSize:
                                0.0667 * bodyWidth, // Responsive font size
                            fontWeight:
                                FontWeight.w500, // Equivalent to 500 weight
                            height:
                                1.4, // Correct height as a ratio to the font size
                            letterSpacing: -0.48, // Letter spacing as per CSS
                            color: Color(0xFF303030), // Text color from CSS
                          ),
                          overflow: TextOverflow
                              .ellipsis, // This will handle text overflow
                          maxLines: 1, // Ensure text stays on a single line
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
