import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';
import 'package:flutter_svg/svg.dart';

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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              width: bodyWidth * (280 / kDeviceWidth),
                              height: bodyHeight * (170 / kDeviceHeight),
                              padding: EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 10),
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.zero,
                                      height: bodyHeight * (94 / kDeviceHeight),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '해당 책을 삭제할까요?',
                                            style: kTextStyle14(context),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '삭제하시면 복구할 수 없습니다. 어쩌구 저쩌구 정말로 삭제하시겠습니까?',
                                            style: kTextStyle12(context,
                                                opacity: 0.4),
                                          ),
                                        ],
                                      )),

                                  Container(
                                    height: bodyHeight * (40 / kDeviceHeight),
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Color(0xff56698f)
                                                  .withAlpha(
                                                      (0.06 * 255).round()),
                                              foregroundColor:
                                                  Colors.black, // 배경색
                                              minimumSize: Size(
                                                  bodyWidth *
                                                      (116 / kDeviceWidth),
                                                  bodyHeight *
                                                      (40 /
                                                          kDeviceHeight)), // 너비와 높이
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text('닫기')),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xfff82a54),
                                              foregroundColor:
                                                  Colors.white, // 배경색
                                              minimumSize: Size(
                                                  bodyWidth *
                                                      (116 / kDeviceWidth),
                                                  bodyHeight *
                                                      (40 /
                                                          kDeviceHeight)), // 너비와 높이
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text('삭제할게요'))
                                      ],
                                    ),
                                  )

                                  // 다른 위젯들
                                ],
                              ),
                            ),
                          );
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
                        Text(
                          '지금 읽기',
                          style: kTextStyle14(context),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: bodyHeight * (56 / kDeviceHeight),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  Container(
                    height: bodyHeight * (56 / kDeviceHeight),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  )
                ],
              ),
            )
          ],
        ));
  }
}
