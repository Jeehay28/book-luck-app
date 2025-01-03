import 'package:flutter/material.dart';

class GoalCountdown extends StatelessWidget {
  final double heightFactor;

  const GoalCountdown({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * heightFactor, // 8.04% of screen height, 57,
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
              fixedSize: Size(320, 44), // Button size
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
                  height: 24,
                  width: 24, // Image height
                ),
                Text(
                  "목표까지 60분 남았어요!", // Add your desired button label here
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
