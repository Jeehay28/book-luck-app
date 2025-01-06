import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app/providers/minutes_provider.dart';

class GoalCountdown extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const GoalCountdown({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = Provider.of<MinutesProvider>(context).minutes;

    return Container(
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
                Image.asset(
                  'assets/images/lightning.png', // Path to the image
                  height: 0.282 * bodyHeight,
                  width: 0.0556 * bodyWidth, // Image height
                ),
                Text(
                  "목표까지 ${60 - minutes}분 남았어요!", // Add your desired button label here
                  style: TextStyle(
                    color: Color(0xFF303030), // Text color
                    fontSize: 14, // Text size
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
