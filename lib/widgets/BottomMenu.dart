import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final double heightFactor;

  const BottomMenu({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // width: 360,
      height: screenHeight * heightFactor, // 9.87% of screen height, 70,
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
        height: 50,
        width: 320,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Center the Row horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/home.png',
                    height: 24), // Image on top
                // Space between image and text
                Text("홈", style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/bookshelf.png',
                    height: 24), // Image on top
                // Space between image and text
                Text("책장",
                    style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/feed.png',
                    height: 24), // Image on top
                // Space between image and text
                Text("피드",
                    style: TextStyle(fontSize: 12)), // Text at the bottom
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/my-page.png',
                    height: 24), // Image on top
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
