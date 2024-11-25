import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Add some padding for the sides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // First Box
            Container(
              height: 47,
            ),

            Container(
              // width: 360,
              height: 58,
              // color: Colors.blue, // You can customize the color here
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                    Radius.circular(0)), // Optional: rounded corners
              ),
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the Row horizontally
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center the Row vertically
                      children: [
                    SizedBox(width: 20),
                    Container(
                      // width: 113,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 1, // Border width
                        ),
                        color: Colors.transparent, // Transparent background
                        borderRadius: BorderRadius.all(
                            Radius.circular(0)), // Optional: rounded corners
                      ),
                      child: Image.asset(
                        'assets/images/bookluck.png', // Replace with your image path
                        fit: BoxFit
                            .contain, // Adjust how the image fits in the container
                      ),
                    ),
                    SizedBox(width: 144),
                    Container(
                      width: 43,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 1, // Border width
                        ),
                        color: Colors.transparent, // Transparent background
                        borderRadius: BorderRadius.all(
                            Radius.circular(0)), // Optional: rounded corners
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the Row takes only as much space as needed
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Align items vertically centered// Align the content in the center
                        children: [
                          Image.asset(
                            'assets/images/mail.png',
                            fit: BoxFit.contain,
                            width: 24,
                          ),
                          SizedBox(width: 7),
                          Text(
                            '1',
                            style: TextStyle(
                              color: Color(0xFF303030), // Text color
                              fontSize: 14, // Font size
                              fontWeight:
                                  FontWeight.bold, // Optional: Make it bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
            // SizedBox(height: 16), // Add space between the two boxes
            // Second Box
            Container(
              // width: 360,
              height: 122,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                    Radius.circular(0)), // Optional: rounded corners
              ),
              child: Center(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Minimize space between items
                  children: [
                    Image.asset(
                      'assets/images/warning.png', // Replace with your image path
                      width: 50, // Set the width of the image
                      height: 50, // Set the height of the image
                      fit: BoxFit.contain, // Adjust image fit if needed
                    ),
                    SizedBox(height: 10), // Add space between image and text
                    Text(
                      '업데이트된 명언이 없습니다. \n업데이트 전까지 조그만 기다려주세요!',
                      style: TextStyle(
                        color: Color.fromRGBO(48, 48, 48, 0.6),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // 360 * 122
            // Container(
            //   // width: 360,
            //   height: 122,
            //   // color: Colors.green,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.blue, // Border color
            //       width: 1, // Border width
            //     ),
            //     color: Colors.transparent, // Transparent background
            //     borderRadius: BorderRadius.all(
            //         Radius.circular(0)), // Optional: rounded corners
            //   ),
            //   child: Center(
            //     child: Text(
            //       'Second Box',
            //       style: TextStyle(color: Colors.white, fontSize: 16),
            //     ),
            //   ),
            // ),

            // 360 *252
            Container(
              // width: 360,
              height: 252,
              // color: Colors.green,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                    Radius.circular(0)), // Optional: rounded corners
              ),
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(86, 105, 143, 0.04),
                      // Button background color
                      fixedSize: Size(320, 240), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)), // Rounded corners
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
            ),

            // 360 * 70
            Container(
              // width: 360,
              height: 70,
              // color: Colors.green,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                    Radius.circular(0)), // Optional: rounded corners
              ),
              child: Center(
                child: Text(
                  'Second Box',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            // 360 * 57
            Container(
              // width: 360,
              height: 57, // Height of the container
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
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
                      backgroundColor:
                          Color(0xFFFFFFFF), // Button background color
                      fixedSize: Size(320, 44), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)), // Rounded corners
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
            ),

            // 360 *80
            Container(
              // width: 360,
              height: 80, // Parent container height
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ), // Optional: rounded corners
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF303030), // Button background color
                    fixedSize: Size(320, 56), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    // Action for the button
                  },
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Proper spacing
                    children: [
                      // Ensure the text and image align properly
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12), // Add padding to the text
                        child: Text(
                          "독서 시작하기",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF), // Text color
                            fontSize: 18, // Text size
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 12), // Add padding to the image
                        child: Image.asset(
                          'assets/images/right-arrow.png', // Path to the image
                          height: 24,
                          width: 24, // Image height
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 360 * 104
            Container(
              // width: 360,
              height: 104,
              // color: Colors.green,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue, // Border color
                  width: 1, // Border width
                ),
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.all(
                    Radius.circular(0)), // Optional: rounded corners
              ),
              child: Center(
                child: Text(
                  'Second Box',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
