import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenu extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;

  const BottomMenu({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 360,
      height: 0.0987 * bodyHeight, // 9.87% of screen height, 70,
      // color: Colors.green,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1, // Border width
        ),
        color: Colors.transparent, // Transparent background
        borderRadius:
            BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
      ),
      child: Center(
          child: Container(
        height: bodyHeight * 0.0705,
        width: bodyWidth * 0.8889,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Center the Row horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/home.svg',
                    height: bodyHeight * 0.0339), // Image on top
                // Space between image and text
                Text("홈", style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/bookshelf.svg',
                    height: bodyHeight * 0.0339,
                    color: Color.fromARGB(48, 48, 48, 0)
                        .withOpacity(0.3)), // Image on top
                // Space between image and text
                Text("책장",
                    style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/feed.svg',
                    height: bodyHeight * 0.0339), // Image on top
                // Space between image and text
                Text("피드",
                    style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/my-page.svg',
                    height: bodyHeight * 0.0339), // Image on top
                // Space between image and text
                Text("마이페이지",
                    style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
          ],
        ),
      )),
    );
  }
}
