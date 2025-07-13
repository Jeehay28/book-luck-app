import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String image;
  final String author;

  BookItem(this.title, this.image, this.author);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    return Container(
        height: bodyHeight * (72 / kDeviceHeight),
        width: 360,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                image,
                width: bodyWidth * (40 / kDeviceWidth),
                height: bodyHeight * (56 / kDeviceHeight),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: bodyWidth * (196 / kDeviceWidth),
                height: bodyHeight * (46 / kDeviceHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: kTextStyle16(context),
                    ),
                    Text(
                      author,
                      overflow: TextOverflow.ellipsis,
                      style: kTextStyle12(context,
                          opacity: 0.4, weight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ]));
  }
}
