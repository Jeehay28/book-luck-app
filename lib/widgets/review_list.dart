import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/model/review.dart';
import 'package:book_luck_app_demo/model/review_data.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/model/review.dart';

class ReviewList extends StatelessWidget {
  final entries = ReviewData();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: entries.ReviewDataCount,
        itemBuilder: (BuildContext context, int index) {
          final reviewData = entries.reviewData[index];
          return ReviewTile(reviewData);
        });
  }
}

class ReviewTile extends StatelessWidget {
  final Review reviewData;

  ReviewTile(this.reviewData);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Container(
      height: bodyHeight * (128 / kDeviceHeight),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff303030).withAlpha((0.06 * 255).round()),
            width: 1, // thickness of the line
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: bodyWidth * (20 / kDeviceWidth),
          vertical: bodyHeight * (16 / kDeviceHeight)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviewData.readDate,
                style: kTextStyle12(context, opacity: 0.4),
              ),
              Row(
                children: [
                  Text(reviewData.readTime,
                      style: kTextStyle12(context, opacity: 0.4)),
                  Icon(Icons.more_horiz,
                      color: Color(0xff303030).withAlpha((0.4 * 255).round()),
                      size: bodyWidth * (24 / kDeviceWidth))
                ],
              )
            ],
          ),
          SizedBox(
            height: bodyHeight * (12 / kDeviceHeight),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Text(
            reviewData.content,
            softWrap: true,
          )))
        ],
      ),
    );
  }
}
