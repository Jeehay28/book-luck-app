import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';

class BookReviewWriteScreen extends StatelessWidget {
  static const String id = 'book_review_write';

  final String title;
  final String image;
  final String author;

  BookReviewWriteScreen(
      {required this.title, required this.image, required this.author});

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;

    final bool isChecked = false;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          height: bodyHeight * (56 / kDeviceHeight),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.chevron_left,
                  color: Color(0xff303030).withAlpha((0.4 * 255).round()),
                  size: bodyWidth * (24 / kDeviceWidth),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text('독후감 작성', style: kTextStyle16(context))
            ],
          ),
        ),
        Container(
          height: bodyHeight * (72 / kDeviceHeight),
          child: BookItem(title, image, author),
        ),

        // 책 정보

        // 독후감 내용 작성
        Container(
          height: bodyHeight * (392 / kDeviceHeight),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            // autofocus: true,
            maxLength: 500,
            maxLines: null,
            minLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top, // 👉 이 줄 추가!
            decoration: InputDecoration(
              hintText: '독후감을 작성해 주세요.',
              alignLabelWithHint: true, // 필수 아님, Label 있을 때 사용
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                borderSide: BorderSide(
                  color: Color(0xff303030).withAlpha((0.12 * 255).round()),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff303030).withAlpha((0.12 * 255).round()),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff303030).withAlpha(
                      (0.12 * 255).round()), // Stronger color on focus
                  width: 2,
                ),
              ),
            ),
            onChanged: (newValue) {
              print(newValue);
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autofocus: false,
          ),
        ),
        // 내용 없이 등록
        Container(
          height: bodyHeight * (44 / kDeviceHeight),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (newValue) {
                    print(newValue);
                  }),
              Text(
                '내용 없이 등록',
                style: kTextStyle14(context),
              ),
            ],
          ),
        ),
        Container(
          height: bodyHeight * (156 / kDeviceHeight),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('읽은 날짜'), Text('2025년 7월 13일')],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('읽은 시간'), Text('50분30초')],
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(onPressed: null, child: Text('등록'))
            ],
          ),
        )
      ],
    )));
  }
}
