import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_luck_app_demo/providers/minutes_provider.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/model/countdown_status.dart';
import 'package:book_luck_app_demo/widgets/modals/showDialogBox.dart';
import 'package:book_luck_app_demo/widgets/modals/read_modal_bottom_sheet.dart';

class StartReadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MinutesProvider>();
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return SizedBox(
      height: bodyHeight * (80 / kDeviceHeight),
      width: double.infinity,
      child: GestureDetector(
          onTap: () {
            print('독서 시작하기 clicked!');
            provider.startCountdown(userId: '1');
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
                    if (provider.status == CountdownStatus.stopped) ...[
                      Text(
                        provider.buttonText,
                        style: kTextStyle18(context, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: bodyWidth * (24 / kDeviceWidth),
                      )
                    ] else if (provider.status == CountdownStatus.started) ...[
                      Text(
                        provider.buttonText,
                        style: kTextStyle18(context, color: Colors.white),
                      ),
                      Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xffF82A54),
                                foregroundColor: Colors.white,
                                minimumSize: Size(
                                    bodyWidth * (65 / kDeviceWidth),
                                    bodyHeight * (32 / kDeviceHeight)),
                                // 너비와 높이
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
                                    provider.stopCountdown(userId: '1');

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
                                minimumSize: Size(
                                    bodyWidth * (65 / kDeviceWidth),
                                    bodyHeight * (32 / kDeviceHeight)),
                                // 너비와 높이
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
                                    // setState(() {
                                    //   _countdownStatus = CountdownStatus.paused;
                                    // });
                                    provider.pauseCountdown(userId: '1');

                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: Text('일시정지')),
                        ],
                      )
                    ] else if (provider.status == CountdownStatus.paused) ...[
                      Text(
                        provider.buttonText,
                        style: kTextStyle18(context, color: Colors.white),
                      ),
                      Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff15B67C),
                                foregroundColor: Colors.white,
                                minimumSize: Size(
                                    bodyWidth * (65 / kDeviceWidth),
                                    bodyHeight * (32 / kDeviceHeight)),
                                // 너비와 높이
                                padding: EdgeInsets.symmetric(
                                    horizontal: bodyWidth * (6 / kDeviceWidth),
                                    vertical: bodyHeight * (8 / kDeviceHeight)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                provider.startCountdown(userId: '1');
                              },
                              child: Text('다시읽기')),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff4A4A4A),
                                foregroundColor: Colors.white,
                                minimumSize: Size(
                                    bodyWidth * (80 / kDeviceWidth),
                                    bodyHeight * (32 / kDeviceHeight)),
                                // 너비와 높이
                                padding: EdgeInsets.symmetric(
                                    horizontal: bodyWidth * (6 / kDeviceWidth),
                                    vertical: bodyHeight * (8 / kDeviceHeight)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                provider.stopCountdown(userId: '1');
                              },
                              child: Text('나중에 읽기')),
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
