import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app_demo/providers/minutes_provider.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';

class ReadingtimeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    final minutes = Provider.of<MinutesProvider>(context).minutes;
    final goal = Provider.of<MinutesProvider>(context).isGoalAchieved;
    // final minutes = 60;
    // final goal = false;

    print("Minutes: $minutes");
    print("Goal: $goal");

    // Calculate the red percentage (max 100% at 100 minutes)
    final double redPercentage = (minutes / 60);

    // Calculate the width of the red portion of the button (in percentage)
    final double blackWidth = redPercentage *
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
                  children: goal
                      ? [
                          Container(
                            width: bodyWidth * 0.8889,
                            // height: bodyHeight * 0.0282,
                            height: bodyHeight * 0.033,
                            child: Stack(
                              children: [
                                Container(
                                  width: (bodyWidth * 0.8889),
                                  height: bodyHeight * 0.0282,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFF03636), // 빨간색
                                        Color(0xFFF48200), // 주황색
                                        Color(0xFFFCCF04), // 노란색
                                        Color(0xFF19B57B), // 초록색
                                      ],
                                      stops: [
                                        0.0,
                                        0.345,
                                        0.64,
                                        1.0
                                      ], // 각각 색 위치 조정
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          4), // Top-left corner radius
                                      bottomLeft: Radius.circular(
                                          4), // Bottom-left corner radius
                                      topRight: Radius.circular(
                                          4), // Top-left corner radius
                                      bottomRight: Radius.circular(
                                          4), // Bottom-left corner radius
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/readingTimeBar.svg",
                                  width: double.infinity,
                                  // height: bodyHeight * 0.0282,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ]
                      : [
                          Container(
                            width: bodyWidth * 0.8889,
                            // height: bodyHeight * 0.0282,
                            height: bodyHeight * 0.033,
                            child: Stack(
                              children: [
                                Container(
                                  width: (bodyWidth * 0.8889) *
                                      redPercentage, // 60% fill
                                  height: bodyHeight * 0.0282,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF08B57E),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/images/readingTimeBar.svg",
                                  width: double.infinity,
                                  // height: bodyHeight * 0.0282,
                                  fit: BoxFit.cover,
                                ),
                              ],
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
                          fontFamily: 'MabinogiClassic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0).withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          height:
                              1.4, // Correct height as a ratio to the font size
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        "30분",
                        style: TextStyle(
                          fontFamily: 'MabinogiClassic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0).withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          height:
                              1.4, // Correct height as a ratio to the font size
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        "1시간",
                        style: TextStyle(
                          fontFamily: 'MabinogiClassic',
                          fontSize:
                              0.0444 * bodyWidth, // Optional: Adjust font size
                          color: Color.fromARGB(48, 48, 48, 0).withOpacity(0.6),
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
