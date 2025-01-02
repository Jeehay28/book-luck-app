import 'package:flutter/material.dart';
import 'dart:async';

class StartReadingButton extends StatefulWidget {
  final double heightFactor;

  const StartReadingButton({Key? key, required this.heightFactor})
      : super(key: key);

  @override
  _StartReadingButtonState createState() => _StartReadingButtonState();
}

class _StartReadingButtonState extends State<StartReadingButton> {
  // final double heightFactor;

  // const StartReadingButton({Key? key, required this.heightFactor})
  //     : super(key: key);

  String _buttonText = "독서 시작하기"; // Initial text on button
  String _countdownText = "00:00:00"; // Countdown text
  late Timer _timer;
  int _seconds = 0; // Countdown starting at 1 second

  // Change text to "started..." when the button is pressed
  // Start countdown
  void _startCountdown() {
    setState(() {
      _seconds = 0; // Start from 00:00:00
      _buttonText = "00:00:${_seconds.toString().padLeft(2, '0')}";
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _buttonText = "00:00:${_seconds.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * widget.heightFactor, // Dynamic height
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1, // Border width
        ),
        color: Colors.transparent, // Transparent background
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF303030), // Button background color
            fixedSize: Size(320, 56), // Button size
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          onPressed: _startCountdown, // Update text when pressed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  _buttonText,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF), // Text color
                    fontSize: 18, // Text size
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  'assets/images/right-arrow.png',
                  height: 24,
                  width: 24, // Image dimensions
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';

// class StartReadingButton extends StatefulWidget {
//   final double heightFactor;

//   const StartReadingButton({Key? key, required this.heightFactor})
//       : super(key: key);

//   @override
//   _StartReadingButtonState createState() => _StartReadingButtonState();
// }

// class _StartReadingButtonState extends State<StartReadingButton> {
//   late Timer _timer;
//   int _remainingTime = 1; // Initial time (in seconds)
//   bool _isReading = false; // Track if the reading is started

//   // Start countdown
//   void _startCountdown() {
//     setState(() {
//       _isReading = true;
//     });
//     _remainingTime = 1; // Reset to 1 second for the countdown

//     // Create a countdown timer that ticks every second
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_remainingTime > 0) {
//           _remainingTime--;
//         } else {
//           _timer.cancel(); // Stop the timer when countdown finishes
//         }
//       });
//     });
//   }

//   // Stop the reading and reset the UI
//   void _stopReading() {
//     setState(() {
//       _isReading = false;
//     });
//     _timer.cancel(); // Stop the countdown timer
//   }

//   // Pause the countdown
//   void _pauseReading() {
//     setState(() {
//       _timer.cancel(); // Pause the timer
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Container(
//       height: screenHeight * widget.heightFactor, // Dynamic height
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.transparent,
//           width: 1, // Border width
//         ),
//         color: Colors.transparent, // Transparent background
//         borderRadius: BorderRadius.all(Radius.circular(0)),
//       ),
//       child: Center(
//         child: _isReading
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '00:00:${_remainingTime.toString().padLeft(2, '0')}', // Countdown timer
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: _stopReading, // Stop button
//                         child: Text("종료하기"),
//                       ),
//                       SizedBox(width: 20),
//                       ElevatedButton(
//                         onPressed: _pauseReading, // Pause button
//                         child: Text("일시정지"),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF303030), // Button background color
//                   fixedSize: Size(320, 56), // Button size
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   ),
//                 ),
//                 onPressed: _startCountdown, // Start countdown on press
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: Text(
//                         "독서 시작하기",
//                         style: TextStyle(
//                           color: Color(0xFFFFFFFF), // Text color
//                           fontSize: 18, // Text size
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: Image.asset(
//                         'assets/images/right-arrow.png',
//                         height: 24,
//                         width: 24, // Image dimensions
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
