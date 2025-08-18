import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/widgets/modals/search_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/utils/api_endpoints.dart';
import 'package:book_luck_app_demo/model/reading_status.dart';
import 'package:book_luck_app_demo/services/networking.dart';
import 'package:book_luck_app_demo/widgets/modals/reading_modal_bottom_sheet.dart';
import 'package:book_luck_app_demo/screens/book_review_list_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/book.dart';

class BookListItem extends StatefulWidget {
  final String title;
  final String image;
  final String isbn;
  final String author;
  final String description;
  final bool favorite;
  final ReadingStatus status;
  final void Function(Book)? onAddRecent;

  BookListItem(this.title, this.image, this.isbn, this.author, this.description,
      this.favorite, this.status, this.onAddRecent);

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  late bool heart;
  List<BookListItem> recentlySearchedBooks = [];

  @override
  void initState() {
    super.initState();
    heart = widget.favorite; // initialize once
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;

    Future<void> addToFavorite(String userId, String bookId) async {
      if (!heart) {
        try {
          NetworkHelper networkHelper =
              NetworkHelper(ApiEndpoints.addToFavorites, body: {
            'userId': userId,
            'bookId': bookId,
          });

          var result = await networkHelper.postData();

          if (result != null) {
            print(result);
            setState(() {
              heart = true;
            });
          }
        } catch (err) {
          print('Error during addToFavorite: $err');
        }
      }
    }

    Future<void> deleteFromFavorite(String userId, String bookId) async {
      if (heart == true) {
        try {
          NetworkHelper networkHelper = NetworkHelper(
              ApiEndpoints.deleteBookFromWishlist(userId, bookId));

          var result = await networkHelper.deleteData();
          print(result);

          if (result != null) {
            print(result);
            setState(() {
              heart = false;
            });
          }
        } catch (err) {
          print('Error during addToFavorite: $err');
        }
      }
    }

    return Container(
        height: bodyHeight * (72 / kDeviceHeight),
        width: 360,
        child: GestureDetector(
          onTap: () {
            if (widget.status == ReadingStatus.search) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        width: double.infinity,
                        height: bodyHeight * (375 / kDeviceHeight),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SearchModalBottomSheet(
                            widget.title,
                            widget.author,
                            widget.image,
                            widget.description,
                            widget.isbn,
                            widget.onAddRecent),
                      )));
            }
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  widget.image,
                  width: bodyWidth * (40 / kDeviceWidth),
                  height: bodyHeight * (56 / kDeviceHeight),
                ),
                SizedBox(
                  width: bodyWidth * (196 / kDeviceWidth),
                  height: bodyHeight * (46 / kDeviceHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: kTextStyle16(context),
                      ),
                      Text(
                        widget.author,
                        overflow: TextOverflow.ellipsis,
                        style: kTextStyle12(context,
                            opacity: 0.4, weight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                    child: Icon(
                      Icons.more_horiz,
                      color: Color(0xff303030).withAlpha((0.4 * 255).round()),
                    ),
                    onTap: () {
                      if (widget.status == ReadingStatus.wishlist) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                                    child: Container(
                                  width: double.infinity,
                                  height: bodyHeight * (375 / kDeviceHeight),
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: ReadingModalBottomSheet(widget.title,
                                      widget.author, widget.image),
                                )));
                      } else if (widget.status == ReadingStatus.reading ||
                          widget.status == ReadingStatus.finished) {
                        Navigator.pushNamed(
                          context,
                          BookReviewListScreen.id,
                          arguments: {
                            'title': widget.title,
                            'author': widget.author,
                            'image': widget.image,
                          },
                        );
                      }
                    }),
                if (widget.status == ReadingStatus.wishlist)
                  SvgPicture.asset(
                    'assets/images/red_heart.svg',
                    width: bodyWidth * (24 / kDeviceWidth),
                    height: bodyHeight * (24 / kDeviceHeight),
                  ),
                if (widget.status == ReadingStatus.search)
                  GestureDetector(
                    child: SvgPicture.asset(
                      heart
                          ? 'assets/images/red_heart.svg'
                          : 'assets/images/grey_heart.svg',
                      width: bodyWidth * (24 / kDeviceWidth),
                      height: bodyHeight * (24 / kDeviceHeight),
                    ),
                    onTap: () {
                      widget.onAddRecent?.call(Book(
                          title: widget.title,
                          image: widget.image,
                          isbn: widget.isbn,
                          author: widget.author,
                          description: widget.description));
                      print("onAddRecented called!");
                      addToFavorite('1', widget.isbn);
                    },
                  ),
                if (widget.status == ReadingStatus.search)
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/cancel.svg',
                      width: bodyWidth * (24 / kDeviceWidth),
                      height: bodyHeight * (24 / kDeviceHeight),
                    ),
                    onTap: () {
                      deleteFromFavorite('1', widget.isbn);
                    },
                  ),
              ]),
        ));
  }
}
