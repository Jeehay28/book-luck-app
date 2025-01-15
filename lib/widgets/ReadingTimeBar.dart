import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app/providers/minutes_provider.dart';

class ReadingtimeBar extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const ReadingtimeBar({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = Provider.of<MinutesProvider>(context).minutes;

    print("Minutes: $minutes");
    // Calculate the red percentage (max 100% at 100 minutes)
    final double redPercentage = (minutes / 60);

    // Calculate the width of the red portion of the button (in percentage)
    final double redWidth = redPercentage *
        bodyWidth *
        0.8889; // Assuming the width of the button is 320

    return Container(
        // width: 360,
        height: 0.0987 * bodyHeight, // 9.87% of screen height, 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 1, // Border width
          ),
          color: Colors.transparent, // Transparent background
          borderRadius:
              BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Red portion of the button
                    Container(
                      width: redWidth,
                      height: bodyHeight * 0.0282,
                      decoration: BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4), // Top-left corner radius
                          bottomLeft:
                              Radius.circular(4), // Bottom-left corner radius
                        ),
                      ),
                    ),
                    Container(
                      width: (bodyWidth * 0.8889 - redWidth),
                      height: bodyHeight * 0.0282,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(48, 48, 48, 0.24),
                        borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(4), // Top-left corner radius
                          bottomRight:
                              Radius.circular(4), // Bottom-left corner radius
                          topLeft: redWidth == 0
                              ? Radius.circular(4)
                              : Radius.circular(0), // Top-left corner radius
                          bottomLeft: redWidth == 0
                              ? Radius.circular(4)
                              : Radius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: bodyWidth * 0.8889, // Set the width for the container
                  height: bodyHeight * 0.0310,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "0분",
                        style: TextStyle(
                          fontFamily: 'Mabinogi_Classic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0)
                            ..withOpacity(0.6),
                          // Text size
                          fontWeight: FontWeight.w400,
                          height:
                              1.4, // Correct height as a ratio to the font size
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        "30분",
                        style: TextStyle(
                          fontFamily: 'Mabinogi_Classic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0)
                            ..withOpacity(0.6),
                          // Text size
                          fontWeight: FontWeight.w400,
                          height:
                              1.4, // Correct height as a ratio to the font size
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        "1시간",
                        style: TextStyle(
                          fontFamily: 'Mabinogi_Classic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0)
                            ..withOpacity(0.6),
                          // Text size
                          fontWeight: FontWeight.w400,
                          height:
                              1.4, // Correct height as a ratio to the font size
                          letterSpacing: -0.32,
                        ),
                      ),
                    ],
                  )))
            ]));
  }
}
