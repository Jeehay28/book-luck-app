import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:book_luck_app_demo/providers/minutes_provider.dart';

class StartReadingButton extends StatefulWidget {
  final double bodyHeight;
  final double bodyWidth;

  const StartReadingButton({
    Key? key,
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
  static const int initSeconds = 3580;
  int _seconds = initSeconds; // Countdown starting at 1 second
  bool _isCountdownStarted = false; // Flag to track countdown status
  bool _isPaused = false;
  bool _isStopped = false;
  int previous = initSeconds;
  bool _isGoalAchieved = false;

  // Start countdown
  void _startCountdown() {
    setState(() {
      _seconds = previous == initSeconds
          ? initSeconds
          : previous; // Use the passed previous value
      _buttonText = "00:00:00";
      _isCountdownStarted = true; // Start the countdown
      previous = initSeconds;
      _isGoalAchieved = false;
      final goalProvider = Provider.of<MinutesProvider>(context, listen: false);
      goalProvider.setGoal(_isGoalAchieved);
    });

    // print('Starting countdown with previous: $previous');

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds >= 3600) {
          timer.cancel();
          _isCountdownStarted = false;
          _isGoalAchieved = true;
          final goalProvider =
              Provider.of<MinutesProvider>(context, listen: false);
          goalProvider.setGoal(_isGoalAchieved);
          return;
        }

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
    // Show the confirmation popup
    _showPopup(context, () {
      setState(() {
        previous = _seconds; // Save current seconds first
        _timer.cancel(); // Then cancel the countdown timer
        _pauseText = "다시시작"; // Change the pause button text to 'Resume'
        _isCountdownStarted = false; // Mark countdown as paused
        _isPaused = true; // Set the paused state to true
      });
    }, isStopping: false);
  }

  void _stopCountdown() {
    // Show the confirmation popup
    _showPopup(context, () {
      _timer.cancel(); // Cancel the countdown timer
      setState(() {
        previous = initSeconds;
        _pauseText = "다시시작"; // Change the pause button text to 'Resume'
        _isCountdownStarted = false; // Mark countdown as stopped
        _isStopped = true; // Set the stopped state to true
      });
    }, isStopping: true);
  }

  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  void _showPopup(BuildContext context, VoidCallback onConfirm,
      {required bool isStopping}) {
    String title = isStopping ? "독서를 끝낼까요?" : "잠시 독서를 멈출까요?";
    String content =
        isStopping ? "독서를 끝내면 읽은 기록이 사라집니다." : "일시정지하면 나중에 이어서 읽을 수 있어요.";
    String confirmButtonText = isStopping ? "끝낼게요" : "멈출래요";
    String cancelButtonText = "계속 읽을래요";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF), // Set background color to white
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFF5F6F8),
                foregroundColor:
                    Color(0xFF17253D), //for background color backgroundColor:
                padding: const EdgeInsets.all(5.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () => Navigator.pop(context, cancelButtonText),
              child: Text(cancelButtonText),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor:
                      isStopping ? Color(0xFF303030) : Color(0xFFF82A55),
                  foregroundColor:
                      Colors.white, //for background color backgroundColor:
                  padding: const EdgeInsets.all(5.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  )),
              onPressed: () {
                setState(() {
                  if (confirmButtonText == "끝낼게요") {
                    _isStopped = true;
                  } else {
                    _isPaused = true;
                  }
                });
                Navigator.pop(context, confirmButtonText);
              },
              child: Text(confirmButtonText),
            ),
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
              child: (_isCountdownStarted || _isPaused)
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
                              // fontFamily: 'SUITVariable',
                              height:
                                  1.44, // Correct height as a ratio to the font size
                              letterSpacing: -0.36,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _isPaused
                                ? [
                                    ElevatedButton(
                                      onPressed: () {
                                        print("isPaused Clicked...");
                                        _pauseCountdown;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF15B67C),
                                        fixedSize: Size(
                                            widget.bodyWidth * 0.1806,
                                            widget.bodyHeight * 0.0451),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Remove internal padding
                                      ),
                                      child: Text(
                                        "다시읽기",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: widget.bodyWidth * 0.033,
                                            // fontFamily: 'SUITVariable',
                                            fontWeight: FontWeight.w700,
                                            // height: 1.42,
                                            letterSpacing: -0.28),
                                      ),
                                    ),
                                  ]
                                : [
                                    ElevatedButton(
                                      onPressed: _stopCountdown,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFF82A54),
                                        fixedSize: Size(
                                            widget.bodyWidth * 0.1806,
                                            widget.bodyHeight * 0.0451),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Remove internal padding
                                      ),
                                      child: Text(
                                        "종료하기",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: widget.bodyWidth * 0.033,
                                            // fontFamily: 'SUITVariable',
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
                                        fixedSize: Size(
                                            widget.bodyWidth * 0.1806,
                                            widget.bodyHeight * 0.0451),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Remove internal padding
                                      ),
                                      child: Text(
                                        "일시정지",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: widget.bodyWidth * 0.033,
                                            // fontFamily: 'SUITVariable',
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
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "독서 시작하기",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.bodyWidth * 0.0500,
                                fontWeight: FontWeight.w500,
                                // fontFamily: 'SUITVariable',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
