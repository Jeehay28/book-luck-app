import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/widgets/book_item.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/screens/home_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';

class SearchModalBottomSheet extends StatelessWidget {
  final String title;
  final String author;
  final String image;
  final String description;
  final String isbn;

  SearchModalBottomSheet(
      this.title, this.author, this.image, this.description, this.isbn);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;
    Future<void> addToFavorite(String userId, String bookId) async {
      try {
        NetworkHelper networkHelper =
            NetworkHelper(ApiEndpoints.addToFavorites, body: {
          'userId': userId,
          'bookId': bookId,
        });

        var result = await networkHelper.postData();
      } catch (err) {
        print('Error during addToFavorite: $err');
      }
    }

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
          Container(
            height: bodyHeight * (72 / kDeviceHeight),
            child: Text(
              description ?? '', // null-safe
              overflow: TextOverflow.ellipsis,
              maxLines: 4, // adjust this to fit your height
            ),
          ),
          SizedBox(
            height: bodyHeight * (25 / kDeviceHeight),
          ),
          Container(
            height: bodyHeight * (56 / kDeviceHeight),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/red_heart.svg',
                  width: bodyWidth * (24 / kDeviceWidth),
                  height: bodyHeight * (24 / kDeviceHeight),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    addToFavorite('1', isbn);
                  },
                  child: Text(
                    '위시리스트에 추가하기',
                    style: kTextStyle14(context),
                  ),
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
                    '지금 바로 읽기',
                    style: kTextStyle14(context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
