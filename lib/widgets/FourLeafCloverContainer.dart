import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FourLeafCloverContainer extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const FourLeafCloverContainer({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bodyWidth,
      height: bodyHeight * 0.3554, // 35.54% of screen height, 252,
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
              fixedSize:
                  Size(bodyWidth * 0.8889, bodyHeight * 0.3385), // Button size
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
                SvgPicture.asset(
                    'assets/images/layer_1.svg', // Path to the image
                    height: bodyHeight * 0.1711,
                    width: bodyWidth * 0.4167),
              ],
            )),
      ),
    );
  }
}
