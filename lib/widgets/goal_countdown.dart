import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app_demo/providers/minutes_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';

class GoalCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    final minutes = Provider.of<MinutesProvider>(context).minutes;
    final goal = Provider.of<MinutesProvider>(context).goal;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 0.0804 * bodyHeight, // 8.04% of screen height, 57,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 1, // Border width
          ),
          color: Colors.transparent, // Transparent background
          borderRadius: BorderRadius.all(
            Radius.circular(0), // Optional: rounded corners
          ),
        ),
        child: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFFFFF), // Button background color
                // fixedSize: Size(320, 44), // Button size
                fixedSize: Size(0.8889 * bodyWidth, 0.0621 * bodyHeight),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(8)), // Rounded corners
                ),
              ),
              onPressed: () {
                // Action for the button
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/lightning.svg', // Path to the image
                    // height: 0.0176 * bodyHeight,
                    // width: 0.07 * bodyWidth,
                    // Set the color heret color
                  ),
                  SizedBox(
                    width: 0.0056 * bodyWidth,
                  ),
                  Text(
                    goal
                        ? "목표를 달성했어요!"
                        : "목표까지 ${60 - minutes}분 남았어요!", // Add your desired button label here
                    style: TextStyle(
                      color: Color(0xFF303030), // Text color
                      // fontFamily: 'SUITVariable',
                      fontSize: 0.0389 * bodyWidth, // Text size
                      fontWeight: FontWeight.w500,
                      height:
                          1.42, // Correct height as a ratio to the font size
                      letterSpacing: -0.28,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
