import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:book_luck_app_demo/providers/minutes_provider.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/model/countdown_status.dart';
import 'package:book_luck_app_demo/widgets/modals/showDialogBox.dart';
import 'package:book_luck_app_demo/widgets/modals/read_modal_bottom_sheet.dart';

class StartReadingButton extends StatefulWidget {
  @override
  _StartReadingButtonState createState() => _StartReadingButtonState();
}

class _StartReadingButtonState extends State<StartReadingButton> {
  String _buttonText = "독서 시작하기"; // Initial text on button
  String _pauseText = "일시정지";
  late Timer _timer;
  static const int initSeconds = 3600;
  int _seconds = initSeconds; // Countdown starting at 1 second
  bool _isCountdownStarted = false; // Flag to track countdown status
  bool _isPaused = false;
  bool _isStopped = false;
  int previous = initSeconds;
  bool _isGoalAchieved = false;
  CountdownStatus _countdownStatus = CountdownStatus.stopped;

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

        final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
        final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
        final seconds = (_seconds % 60).toString().padLeft(2, '0');

        _buttonText = "$hours:$minutes:$seconds";

        final minutesProvider =
            Provider.of<MinutesProvider>(context, listen: false);
        minutesProvider.setMinutes(
            int.parse(minutes)); // Update the minutes in the provider
      });
    });
  }

  void _pauseCountdown() {
    setState(() {
      previous = _seconds; // Save current seconds first
      _timer.cancel(); // Then cancel the countdown timer
      _pauseText = "다시시작"; // Change the pause button text to 'Resume'
      _isPaused = true; // Set the paused state to true
    });
  }

  void _stopCountdown() {
    setState(() {
      previous = initSeconds;
      _pauseText = "다시시작"; // Change the pause button text to 'Resume'
      _isCountdownStarted = false; // Mark countdown as stopped
      _isStopped = true; // Set the stopped state to true
    });
  }

  String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return GestureDetector(
      onTap: () {
        print('독서 시작하기 clicked!');
        setState(() {
          _countdownStatus = CountdownStatus.started;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: bodyHeight * (12 / kDeviceHeight),
            horizontal: bodyWidth * (20 / kDeviceWidth)),
        child: Container(
          height: bodyHeight * (56 / kDeviceHeight),
          width: bodyWidth * (320 / kDeviceWidth),
          decoration: BoxDecoration(
            color: Color(0xff303030),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: bodyHeight * (12 / kDeviceHeight),
                horizontal: bodyWidth * (20 / kDeviceWidth)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_countdownStatus == CountdownStatus.stopped) ...[
                  Text(
                    '독서 시작하기',
                    style: kTextStyle18(context, color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: bodyWidth * (24 / kDeviceWidth),
                  )
                ] else if (_countdownStatus == CountdownStatus.started) ...[
                  Text(
                    '00:10:21',
                    style: kTextStyle18(context, color: Colors.white),
                  ),
                  Row(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xffF82A54),
                            foregroundColor: Colors.white,
                            minimumSize: Size(bodyWidth * (65 / kDeviceWidth),
                                bodyHeight * (32 / kDeviceHeight)), // 너비와 높이
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (6 / kDeviceWidth),
                                vertical: bodyHeight * (8 / kDeviceHeight)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialogBox(
                              context,
                              '독서를 끝낼까요?',
                              '독서를 종료하면 현재까지의 기록이 저장됩니다. 이후 새로운 책을 시작하거나 기존 책을 이어 읽을 수 있습니다.',
                              '닫기',
                              '끝낼게요',
                              Color(0xffF82A54),
                              () {
                                Navigator.pop(context);
                                setState(() {
                                  _countdownStatus = CountdownStatus.stopped;
                                });

                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ReadModalBottomSheet();
                                    });
                              },
                            );
                          },
                          child: Text('종료하기')),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff4A4A4A),
                            foregroundColor: Colors.white,
                            minimumSize: Size(bodyWidth * (65 / kDeviceWidth),
                                bodyHeight * (32 / kDeviceHeight)), // 너비와 높이
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (6 / kDeviceWidth),
                                vertical: bodyHeight * (8 / kDeviceHeight)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialogBox(
                              context,
                              '잠시 독서를 멈출까요?',
                              "일시정지한 책은 '다시 읽기'를 누르면 이어서 읽을 수 있습니다.",
                              '계속 읽을래요',
                              '멈출래요',
                              Color(0xff303030),
                              () {
                                setState(() {
                                  _countdownStatus = CountdownStatus.paused;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Text('일시정지')),
                    ],
                  )
                ] else if (_countdownStatus == CountdownStatus.paused) ...[
                  Text(
                    '00:10:21',
                    style: kTextStyle18(context, color: Colors.white),
                  ),
                  Row(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff15B67C),
                            foregroundColor: Colors.white,
                            minimumSize: Size(bodyWidth * (65 / kDeviceWidth),
                                bodyHeight * (32 / kDeviceHeight)), // 너비와 높이
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (6 / kDeviceWidth),
                                vertical: bodyHeight * (8 / kDeviceHeight)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _countdownStatus = CountdownStatus.started;
                            });
                          },
                          child: Text('다시읽기')),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff4A4A4A),
                            foregroundColor: Colors.white,
                            minimumSize: Size(bodyWidth * (80 / kDeviceWidth),
                                bodyHeight * (32 / kDeviceHeight)), // 너비와 높이
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (6 / kDeviceWidth),
                                vertical: bodyHeight * (8 / kDeviceHeight)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('나중에 읽기')),
                    ],
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
