import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/screens/book_pictorial_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/app_text_styles.dart';
import '../utils/constants.dart';
import '../widgets/privacy_policy_popup.dart';
import 'mypage_screen.dart';

class SettingScreen extends StatefulWidget {
  static const String id = 'setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start, // Distribute space
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: bodyWidth * (20 / kDeviceWidth),
                    vertical: bodyHeight * (12 / kDeviceHeight)),
                child: Container(
                  height: bodyHeight * (34 / kDeviceHeight),
                  width: bodyWidth * (320 / kDeviceWidth),
                  child: Row(
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/black_clover.svg',
                          width: bodyWidth * (16 / kDeviceWidth),
                          height: bodyHeight * (16 / kDeviceHeight),
                        ),
                      ),
                      SizedBox(
                        width: bodyWidth * (4 / kDeviceWidth),
                      ),
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/bookluck_text.svg',
                          width: bodyWidth * (93 / kDeviceWidth),
                          height: bodyHeight * (16 / kDeviceHeight),
                        ),
                      ),
                      SizedBox(
                        width: bodyWidth * (103 / kDeviceWidth),
                      ),
                      Container(
                        width: bodyWidth * (104 / kDeviceWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, MyPageScreen.id);
                              },
                              child: SvgPicture.asset(
                                'assets/images/book_at_mypage_grey.svg',
                                width: bodyWidth * (24 / kDeviceWidth),
                                height: bodyHeight * (24 / kDeviceHeight),
                              ),
                            ),
                            SizedBox(
                              width: bodyWidth * (16 / kDeviceWidth),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, BookPictorialBookScreen.id);
                              },
                              child: SvgPicture.asset(
                                'assets/images/blank_clover.svg',
                                width: bodyWidth * (24 / kDeviceWidth),
                                height: bodyHeight * (24 / kDeviceHeight),
                              ),
                            ),
                            SizedBox(
                              width: bodyWidth * (16 / kDeviceWidth),
                            ),
                            SvgPicture.asset(
                              'assets/images/cogwheel.svg',
                              width: bodyWidth * (24 / kDeviceWidth),
                              height: bodyHeight * (24 / kDeviceHeight),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // 북럭 메세지 받기
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: bodyWidth * (20 / kDeviceWidth),
                    vertical: bodyHeight * (12 / kDeviceHeight)),
                child: Container(
                  width: bodyWidth * (320 / kDeviceWidth),
                  height: bodyHeight * (60 / kDeviceHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '북럭 메시지 받기',
                        style: kTextStyle16(context, weight: FontWeight.w700),
                      ),
                      Text(
                        '하루에 한번 독서 알림을 받아요',
                        style: kTextStyle12(context,
                            weight: FontWeight.w500, opacity: 0.4),
                      )
                    ],
                  ),
                ),
              ),

              // Bar
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: bodyHeight * (12 / kDeviceHeight)),
                child: Container(
                  height: bodyHeight * (8 / kDeviceHeight),
                  decoration:
                      BoxDecoration(color: Color(0xFF56698F).withOpacity(0.04)),
                ),
              ),

              // 자주 묻는 질문
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: bodyWidth * (20 / kDeviceWidth),
                    vertical: bodyHeight * (8 / kDeviceHeight)),
                child: Container(
                  width: bodyWidth * (320 / kDeviceWidth),
                  height: bodyHeight * (60 / kDeviceHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '자주 묻는 질문',
                        style: kTextStyle16(context, weight: FontWeight.w700),
                      ),
                      Text(
                        '문의하기',
                        style: kTextStyle16(context, weight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),

              // Bar
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: bodyHeight * (12 / kDeviceHeight)),
                child: Container(
                  height: bodyHeight * (8 / kDeviceHeight),
                  decoration:
                      BoxDecoration(color: Color(0xFF56698F).withOpacity(0.04)),
                ),
              ),

              // 서비스 이용약관
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: bodyWidth * (20 / kDeviceWidth),
                    vertical: bodyHeight * (8 / kDeviceHeight)),
                child: Container(
                  width: bodyWidth * (320 / kDeviceWidth),
                  height: bodyHeight * (60 / kDeviceHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '서비스 이용약관',
                        style: kTextStyle16(context, weight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: '',
                            pageBuilder: (context, anim1, anim2) {
                              return const PrivacyPolicyPopup();
                            },
                            transitionBuilder: (context, anim1, anim2, child) {
                              return SlideTransition(
                                position: Tween(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero)
                                    .animate(anim1),
                                child: child,
                              );
                            },
                          );
                        },
                        child: Text(
                          '개인정보 처리방침',
                          style: kTextStyle16(context, weight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    )));
  }
}
