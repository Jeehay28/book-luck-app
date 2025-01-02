import 'package:flutter/material.dart';

class ReadingtimeBar extends StatelessWidget {
  final double heightFactor;

  const ReadingtimeBar({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
        // width: 360,
        height: screenHeight * heightFactor, // 9.87% of screen height, 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Border color
            width: 1, // Border width
          ),
          color: Colors.transparent, // Transparent background
          borderRadius:
              BorderRadius.all(Radius.circular(0)), // Optional: rounded corners
        ),
        child: Column(children: [
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(
                      48, 48, 48, 0.24), // Button background color
                  fixedSize: Size(320, 20), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(8)), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Action for the button
                },
                child: null),
          ),
          Container(
              width: 320, // Set the width for the container
              height: 22,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text("0분"), Text("30분"), Text("1시간")]),
              ))
        ]));
  }
}
