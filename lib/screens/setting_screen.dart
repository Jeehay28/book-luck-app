import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/widgets/slide_toggle.dart';
import 'package:flutter/material.dart';
import '../styles/app_text_styles.dart';
import '../utils/constants.dart';
import '../widgets/privacy_policy_popup.dart';

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

    return Column(
      children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '북럭 메시지 받기',
                      style: kTextStyle16(context, weight: FontWeight.w700),
                    ),
                    SlideToggle()
                  ],
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
          padding:
              EdgeInsets.symmetric(vertical: bodyHeight * (12 / kDeviceHeight)),
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
          padding:
              EdgeInsets.symmetric(vertical: bodyHeight * (12 / kDeviceHeight)),
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
                          position:
                              Tween(begin: const Offset(1, 0), end: Offset.zero)
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
    );
  }
}
