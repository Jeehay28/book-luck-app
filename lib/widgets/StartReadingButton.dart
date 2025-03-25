import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart'; // Import the Provider package
import 'package:book_luck_app_demo/providers/minutes_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartReadingButton extends StatefulWidget {
  // final double heightFactor;
  final double bodyHeight;
  final double bodyWidth;

  const StartReadingButton({
    Key? key,
    // required this.heightFactor
    required this.bodyHeight,
    required this.bodyWidth,
  }) : super(key: key);

  @override
  _StartReadingButtonState createState() => _StartReadingButtonState();
}

class _StartReadingButtonState extends State<StartReadingButton> {
  String _buttonText = "독서 시작하기"; // Initial text on button
  String _pauseText = "일시정지";
  late Timer _timer;
  int _seconds = 300; // Countdown starting at 1 second
  bool _isCountdownStarted = false; // Flag to track countdown status
  bool _isPaused = false;

  // Start countdown
  void _startCountdown({int? previous}) {
    setState(() {
      _seconds = previous ?? 300; // Start from 00:00:00
      _buttonText = "00:00:00";
      _isCountdownStarted = true; // Start the countdown
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        // Calculate hours, minutes, and seconds
        final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
        final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
        final seconds = (_seconds % 60).toString().padLeft(2, '0');

        _buttonText = "$hours:$minutes:$seconds";

        // Update minutes in MinutesProvider
        final minutesProvider =
            Provider.of<MinutesProvider>(context, listen: false);
        minutesProvider.setMinutes(
            int.parse(minutes)); // Update the minutes in the provider
      });
    });
  }

  // Handle actions for the two new buttons
  void _pauseCountdown() {
    if (_pauseText == "일시정지") {
      // Show the confirmation popup
      _showPopup(context, () {
        _timer.cancel(); // This will cancel the countdown timer

        setState(() {
          _pauseText = "다시시작"; // Change the pause button text to 'Resume'
        });
      });
    } else {
      _startCountdown(previous: _seconds);
    }

    setState(() {
      _buttonText = _buttonText; // Display Paused text
      _pauseText = _pauseText == "일시정지" ? "다시시작" : "일시정지";
      _seconds = _seconds;
      _isCountdownStarted = true;
    });
  }

  void _resetCountdown() {
    _timer.cancel();
    setState(() {
      _buttonText = "독서 시작하기"; // Reset to initial text
      _seconds = 300;
      _isCountdownStarted = false;
    });

    _seconds = 300;
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');

    final minutesProvider =
        Provider.of<MinutesProvider>(context, listen: false);
    minutesProvider.setMinutes(int.parse(minutes));
  }

  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  void _showPopup(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("독서를 끝낼까요?"),
          content: Text("독서를 끝내면 읽은 기록이 사라집니다."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.4, // Make the width half of the dialog's width
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            48, 48, 48, 0.24), // Set background color
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      child: FittedBox(
                        fit: BoxFit
                            .scaleDown, // Ensures the text fits inside the button
                        child: Text(
                          "계속 읽을래요",
                          style: TextStyle(
                              color: Colors.white, // Text color
                              fontFamily: 'SUITVariable'),
                        ),
                      ))),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onConfirm(); // Call the passed in function (pause)
                },
                child: FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.4,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF82A54), // Set background color
                          borderRadius:
                              BorderRadius.circular(8), // Set border radius
                        ),
                        child: FittedBox(
                          fit: BoxFit
                              .scaleDown, // Ensures the text fits inside the button
                          child: Text(
                            "끝낼께요.",
                            style: TextStyle(
                                color: Colors.white, // Text color
                                fontFamily: 'SUITVariable'),
                          ),
                        )))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Ensures ripple effect works
      child: InkWell(
        onTap: _isCountdownStarted ? null : _startCountdown,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: widget.bodyHeight * 0.0790,
          width: widget.bodyWidth * 0.8889,
          decoration: BoxDecoration(
            color: Color(0xFF303030), // Always black background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: _isCountdownStarted
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.bodyWidth *
                            0.0333), // Adds 16px margin on left and right)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTime(_seconds),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.bodyWidth * 0.0500,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SUITVariable',
                            height:
                                1.44, // Correct height as a ratio to the font size
                            letterSpacing: -0.36,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _resetCountdown,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF82A54),
                                fixedSize: Size(widget.bodyWidth * 0.1806,
                                    widget.bodyHeight * 0.0451),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                "종료하기",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: widget.bodyWidth * 0.033,
                                    fontFamily: 'SUITVariable',
                                    fontWeight: FontWeight.w700,
                                    // height: 1.42,
                                    letterSpacing: -0.28),
                              ),
                            ),
                            SizedBox(width: widget.bodyWidth * 0.0222),
                            ElevatedButton(
                              onPressed: _pauseCountdown,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4A4A4A),
                                fixedSize: Size(widget.bodyWidth * 0.1806,
                                    widget.bodyHeight * 0.0451),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                _isPaused ? "종료하기" : "일시정지",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: widget.bodyWidth * 0.033,
                                    fontFamily: 'SUITVariable',
                                    fontWeight: FontWeight.w700,
                                    // height: 1.42,
                                    letterSpacing: -0.28),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "독서 시작하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.bodyWidth * 0.0500,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SUITVariable',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
