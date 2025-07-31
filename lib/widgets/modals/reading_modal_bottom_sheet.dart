import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:book_luck_app_demo/widgets/modals/showDialogBox.dart';
import 'package:book_luck_app_demo/screens/book_review_write_screen.dart';
import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';

class ReadingModalBottomSheet extends StatelessWidget {
  final String title;
  final String author;
  final String image;

  ReadingModalBottomSheet(this.title, this.author, this.image);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            BookItem(title, image, author),
            SizedBox(
              height: bodyHeight * (25 / kDeviceHeight),
            ),
            Container(
              height: bodyHeight * (224 / kDeviceHeight),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialogBox(
                        context,
                        '해당 책을 삭제할까요?',
                        '책을 삭제하면 관련 기록도 함께 사라집니다.\n계속 진행할까요?',
                        '닫기',
                        '삭제할게요',
                        Color(0xfff82a54),
                        () {
                          Navigator.pushNamed(
                              context, BookReviewCompleteScreen.id);
                        },
                      );
                    },
                    child: Container(
                      height: bodyHeight * (56 / kDeviceHeight),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/trash.svg',
                            width: bodyWidth * (24 / kDeviceWidth),
                            height: bodyHeight * (24 / kDeviceHeight),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '삭제하기',
                            style: kTextStyle14(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: bodyHeight * (56 / kDeviceHeight),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/reading.svg',
                          width: bodyWidth * (24 / kDeviceWidth),
                          height: bodyHeight * (24 / kDeviceHeight),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, HomeScreen.id);
                          },
                          child: Text(
                            '지금 읽기',
                            style: kTextStyle14(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        BookReviewWriteScreen.id,
                        arguments: {
                          'title': title,
                          'author': author,
                          'image': image,
                        },
                      );
                    },
                    child: Container(
                      height: bodyHeight * (56 / kDeviceHeight),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/pencil.svg',
                            width: bodyWidth * (24 / kDeviceWidth),
                            height: bodyHeight * (24 / kDeviceHeight),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '독후감 쓰기',
                            style: kTextStyle14(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialogBox(
                        context,
                        '해당 책을 완독하셨나요?',
                        '🎉 완독 축하드려요!\n이제 이 책은 당신의 멋진 독서 이력에 당당히 등록됩니다.',
                        '닫기',
                        '완독했어요',
                        Color(0xff303030),
                        () {
                          Navigator.pushNamed(
                              context, BookReviewCompleteScreen.id);
                        },
                      );
                    },
                    child: Container(
                      height: bodyHeight * (56 / kDeviceHeight),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            width: bodyWidth * (24 / kDeviceWidth),
                            height: bodyHeight * (24 / kDeviceHeight),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '다 읽었어요',
                            style: kTextStyle14(context),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
