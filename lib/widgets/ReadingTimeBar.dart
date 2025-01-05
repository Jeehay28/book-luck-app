import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app/providers/minutes_provider.dart';

class ReadingtimeBar extends StatelessWidget {
  final double heightFactor;

  const ReadingtimeBar({
    Key? key,
    required this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minutes = Provider.of<MinutesProvider>(context).minutes;

    // Calculate the red percentage (max 100% at 100 minutes)
    final double redPercentage = (minutes / 60);

    // Calculate the width of the red portion of the button (in percentage)
    final double redWidth =
        redPercentage * 320; // Assuming the width of the button is 320

    // // Blend red and the existing color based on redPercentage
    // final blendedColor = Color.lerp(
    //   Colors.red,
    //   Color.fromRGBO(48, 48, 48, 0.24), // Existing color
    //   1 - redPercentage, // Blend ratio (inverted for Color.lerp)
    // );

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
                  // Dynamic blended color
                  padding: EdgeInsets.zero,
                  fixedSize: Size(320, 20), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(8)), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Action for the button
                },
                child: Row(
                  children: [
                    // Red portion of the button
                    Container(
                      width: redWidth,
                      // The width will depend on the minutes
                      height: 44, // Button height
                      decoration: BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), // Top-left corner radius
                          bottomLeft:
                              Radius.circular(8), // Bottom-left corner radius
                        ),
                      ),
                    ),
                    // Existing color portion of the button
                    // Container(
                    //   width: 320 - redWidth, // The remaining width
                    //   height: 44, // Button height
                    //   decoration: BoxDecoration(
                    //     color:
                    //         Color.fromRGBO(48, 48, 48, 0.24), // Existing color
                    //     borderRadius: BorderRadius.only(
                    //       topRight:
                    //           Radius.circular(8), // Top-left corner radius
                    //       bottomRight:
                    //           Radius.circular(8), // Bottom-left corner radius
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          ),
          Container(
              width: 320, // Set the width for the container
              height: 22,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("0분"), Text("30분"), Text("1시간")]),
              ))
        ]));
  }
}
