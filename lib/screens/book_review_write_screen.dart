import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';
import 'package:book_luck_app_demo/widgets/modals/showDialogBox.dart';
import 'package:book_luck_app_demo/screens/book_review_complete_screen.dart';
import 'package:intl/intl.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';

class BookReviewWriteScreen extends StatefulWidget {
  static const String id = 'book_review_write';

  final String title;
  final String image;
  final String author;
  final String isbn;

  BookReviewWriteScreen(
      {required this.title,
      required this.image,
      required this.author,
      required this.isbn});

  @override
  State<BookReviewWriteScreen> createState() => _BookReviewWriteScreenState();
}

class _BookReviewWriteScreenState extends State<BookReviewWriteScreen> {
  bool isChecked = false;
  String review = '';

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;

    Future<void> recordBooks(
        {int userId = 1,
        // required String bookId,
        required int duration,
        required String review}) async {
      try {
        NetworkHelper networkHelper =
            NetworkHelper(ApiEndpoints.recordBooks, body: {
          'userId': userId,
          'status': 'FINISHED',
          'bookId': widget.isbn,
          'duration': duration,
          'endDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'review': review
        });

        await networkHelper.postData();
      } catch (err) {
        print('Error during recordBooks: $err');
      }
    }

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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BookItem(widget.title, widget.image, widget.author),
        ),

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
              hintStyle:
                  kTextStyle14(context, weight: FontWeight.w400, opacity: 0.6),
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
              setState(() {
                review = newValue;
              });
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
                    setState(() {
                      isChecked = newValue!;
                    });
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
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: bodyHeight * (12 / kDeviceHeight)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '읽은 날짜',
                    style: kTextStyle14(context, opacity: 0.6),
                  ),
                  Text(
                    // '2025년 7월 13일',
                    DateFormat('yyyy년 M월 d일').format(DateTime.now()),
                    style: kTextStyle14(context),
                  )
                ],
              ),
              SizedBox(height: bodyHeight * (12 / kDeviceHeight)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '읽은 시간',
                    style: kTextStyle14(context, opacity: 0.6),
                  ),
                  Text(
                    '50분30초',
                    style: kTextStyle14(context),
                  )
                ],
              ),
              SizedBox(height: bodyHeight * (12 / kDeviceHeight)),
              TextButton(
                onPressed: () {
                  showDialogBox(
                      context,
                      '해당 책을 완독하셨나요?',
                      "책을 끝까지 읽으셨다면 '완독' 처리로 기록을\n마무리할 수 있어요.",
                      '덜 읽었어요',
                      '완독했어요',
                      Color(0xff303030), () {
                    recordBooks(
                        userId: 1,
                        // bookId: '9791190090261',
                        duration: 180,
                        review: review);
                    Navigator.pushNamed(context, BookReviewCompleteScreen.id);
                  });
                },
                child: Text(
                  '등록',
                  style: kTextStyle16(context, color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff303030),
                  foregroundColor: Colors.white, // 배경색
                  minimumSize: Size(bodyWidth * (320 / kDeviceWidth),
                      bodyHeight * (56 / kDeviceHeight)), // 너비와 높이
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    )));
  }
}
