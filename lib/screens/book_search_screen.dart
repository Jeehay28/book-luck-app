import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/book_list.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';
import 'dart:async'; // For Timer

class BookSearchScreen extends StatefulWidget {
  static const String id = 'booksearch';

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final selectedReadingStatus = '책 찾기';
  final TextEditingController _controller = TextEditingController();
  String inputValues = "";
  String searchKeyword = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      // Only update keyword here (after user stops typing)
      setState(() {
        searchKeyword = value;
      });

      print(searchKeyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.bodyWidth;
    final bodyHeight = context.bodyHeight;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          // 책 찾기
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
                Text('책 찾기', style: kTextStyle16(context))
              ],
            ),
          ),
          // 책 제목 검색
          Container(
            height: bodyHeight * (72 / kDeviceHeight),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              // autofocus: true,
              decoration: InputDecoration(
                hintText: '책 제목을 검색해주세요',
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
              controller: _controller,
              onChanged: _onTextChanged,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              autofocus: false,
            ),
          ),
          // 최근 검색한 책
          Container(
            height: bodyHeight * (52 / kDeviceHeight),
            alignment: Alignment.topLeft, // align inside the container
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              '최근 검색한 책',
              style: kTextStyle14(context, opacity: 0.4),
            ),
          ),
          // 최근 검색한 책 리스트
          Expanded(
              child: BookList(
                  ReadingStatusExtension.from(selectedReadingStatus),
                  keyword: searchKeyword)),
        ]),
      ),
    );
  }
}
