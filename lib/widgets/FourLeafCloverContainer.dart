import 'package:flutter/material.dart';

class FourLeafCloverContainer extends StatelessWidget {
  final double heightFactor;

  const FourLeafCloverContainer({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // width: 360,
      height: screenHeight * heightFactor, // 35.54% of screen height, 252,
      // color: Colors.green,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent, // Border color
          width: 1, // Border width
        ),
        color: Colors.transparent, // Transparent background
        borderRadius:
            BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
      ),
      child: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(86, 105, 143, 0.04),
              // Button background color
              fixedSize: Size(320, 240), // Button size
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(8)), // Rounded corners
              ),
              elevation:
                  0, // Remove shadow to mimic semi-transparent background better
            ),
            onPressed: () {
              // Action for the button
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/layer_1.png', // Path to the image
                  height: 121.32,
                  width: 150, // Image height
                ),
              ],
            )),
      ),
    );
  }
}
