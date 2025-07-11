import 'package:flutter/material.dart';
import 'dart:async';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_box_styles.dart';

class QuoteContainer extends StatefulWidget {
  @override
  _QuoteContainerState createState() => _QuoteContainerState();
}

class _QuoteContainerState extends State<QuoteContainer> {
  List<Map<String, dynamic>> _quote = [
    {"id": 12, "phrase": "업데이트된 명언이 없습니다.", "name": "업데이트 전까지 조금만 기다려주세요!"}
  ];

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  Future<void> getQuote() async {
    NetworkHelper networkHelper = NetworkHelper(ApiEndpoints.getQuotes);

    var dynamicData = await networkHelper.getData();

    if (dynamicData != null) {
      List<Map<String, dynamic>> quoteData =
          List<Map<String, dynamic>>.from(dynamicData);

      for (var i = 0; i < quoteData.length; i++) {
        String temp = quoteData[i]['phrase'] ?? '';

        if (temp.length > 24) {
          String newQuote = temp.substring(0, 23) + '\n' + temp.substring(23);
          quoteData[i]['phrase'] = newQuote;
        }
      }
      setState(() {
        _quote = quoteData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Container(
      width: double.infinity,
      height: bodyHeight * (122 / kDeviceHeight),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _quote
              .map((quote) => SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        width: bodyWidth * (280 / kDeviceWidth),
                        height: bodyHeight * (104 / kDeviceHeight),
                        decoration: kBoxDecoration,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quote['phrase'] ??
                                  'No phrase available', // Access the 'phrase' key
                              style: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 1),
                                fontSize: 0.0444 * bodyWidth,
                                fontFamily: 'MabinogiClassic',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.0009 * bodyWidth,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: bodyHeight * 0.011),
                            Text(
                              quote['name'] ??
                                  'Unknown author', // Access the 'name' key
                              style: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 0.6),
                                fontSize: 0.0389 * bodyWidth,
                                fontFamily: 'MabinogiClassic',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.0008 * bodyWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
