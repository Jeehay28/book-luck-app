import 'package:book_luck_app_demo/screens/setting_screen.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:book_luck_app_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../services/networking.dart';
import '../utils/api_endpoints.dart';
import '../widgets/monthly_reading_line_chart.dart';
import 'book_pictorial_book_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MyPageScreen extends StatefulWidget {
  static const String id = 'mypage';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final GlobalKey _containerKey = GlobalKey();
  String selectedTab = '기록';
  final List<String> options = ['최신순', '오래된순'];
  String dropdownValue = '최신순';
  bool hideIcons = false;
  List<Map<String, dynamic>> _bookReceipts = [];
  int _currentIndex = 0;

  Future<bool> _ensureGalleryPermission() async {
    if (Platform.isIOS) {
      // iOS 시뮬레이터면 그냥 true 반환
      if (!await _isPhysicalDevice()) return true;

      // 실제 기기
      try {
        var addOnly = await Permission.photosAddOnly.request();
        if (addOnly.isGranted) return true;
      } catch (e) {
        debugPrint('photosAddOnly not supported: $e');
      }

      return false;
    }

    if (Platform.isAndroid) {
      var status = await Permission.photos.request();
      if (status.isGranted) return true;

      status = await Permission.storage.request();
      return status.isGranted;
    }

    return true;
  }

  Future<void> _saveToGallery() async {
    print('사진첩에 저장하기 클릭');
    final ok = await _ensureGalleryPermission();
    print(ok);
    if (!ok) return;

    setState(() {
      hideIcons = true;
    });

    // Make sure the boundary is laid out
    await WidgetsBinding.instance.endOfFrame;

    final boundary = _containerKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) {
      debugPrint('RepaintBoundary not found yet');
      return;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return;

    final pngBytes = byteData.buffer.asUint8List();
    await ImageGallerySaverPlus.saveImage(
      pngBytes,
      name: 'my_container_image',
    );

    setState(() {
      hideIcons = false;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          backgroundColor: Color(0xFF31353D).withOpacity(0.8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Color(0xFF3B6CFF), // your blue
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                '사진첩에 저장되었습니다.',
                style: kTextStyle16(context,
                    weight: FontWeight.w700, color: Colors.white),
              ),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> _isPhysicalDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice ?? true;
  }

  Future<void> _shareRepaintBoundary() async {
    // Ensure the widget has been laid out this frame
    await WidgetsBinding.instance.endOfFrame;

    final boundary = _containerKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) return;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return;

    final bytes = byteData.buffer.asUint8List();
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/bookluck_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(path);
    await file.writeAsBytes(bytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Shared from BookLuck',
      subject: 'My Page',
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          backgroundColor: const Color(0xFF3B6CFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Image ready to share!',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> getReceipts(String userId) async {
    try {
      var url = ApiEndpoints.getReceipts(userId);
      NetworkHelper networkHelper = NetworkHelper(url);

      var result = await networkHelper.getData();

      if (result == null) {
        print('getReceipts: response is null');
      }

      if (result is List) {
        final reviews = result
            .whereType<Map>() // 혹시 섞여있을 타입 걸러주기
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

        if (!mounted) return;
        if (reviews.isNotEmpty) {
          setState(() {
            _bookReceipts = reviews;
            print(_bookReceipts);
          });
        }
        return;
      }
    } catch (err) {
      print('Error during getReviews: $err');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReceipts('1');
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;
    if (_bookReceipts.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final receipt = _bookReceipts[_currentIndex];

    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.zero, // Add some padding for the sides
                child: SizedBox(
                    height: bodyHeight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Distribute space
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (20 / kDeviceWidth),
                                vertical: bodyHeight * (12 / kDeviceHeight)),
                            child: Container(
                              height: bodyHeight * (34 / kDeviceHeight),
                              width: bodyWidth * (320 / kDeviceWidth),
                              child: Row(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/images/black_clover.svg',
                                      width: bodyWidth * (16 / kDeviceWidth),
                                      height: bodyHeight * (16 / kDeviceHeight),
                                    ),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (4 / kDeviceWidth),
                                  ),
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/images/bookluck_text.svg',
                                      width: bodyWidth * (93 / kDeviceWidth),
                                      height: bodyHeight * (16 / kDeviceHeight),
                                    ),
                                  ),
                                  SizedBox(
                                    width: bodyWidth * (103 / kDeviceWidth),
                                  ),
                                  Container(
                                    width: bodyWidth * (104 / kDeviceWidth),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/book_at_mypage.svg',
                                          width:
                                              bodyWidth * (24 / kDeviceWidth),
                                          height:
                                              bodyHeight * (24 / kDeviceHeight),
                                        ),
                                        SizedBox(
                                          width:
                                              bodyWidth * (16 / kDeviceWidth),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                BookPictorialBookScreen.id);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/blank_clover.svg',
                                            width:
                                                bodyWidth * (24 / kDeviceWidth),
                                            height: bodyHeight *
                                                (24 / kDeviceHeight),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              bodyWidth * (16 / kDeviceWidth),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, SettingScreen.id);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/cogwheel.svg',
                                            width:
                                                bodyWidth * (24 / kDeviceWidth),
                                            height: bodyHeight *
                                                (24 / kDeviceHeight),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (20 / kDeviceWidth),
                                vertical: bodyHeight * (16 / kDeviceHeight)),
                            child: Container(
                              height: bodyHeight * (20 / kDeviceHeight),
                              width: bodyWidth * (320 / kDeviceWidth),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          '기록 영수증',
                                          style: kTextStyle14(context),
                                        ),
                                        SizedBox(
                                          width: bodyWidth * (4 / kDeviceWidth),
                                        ),
                                        Text(
                                          '${_bookReceipts.length}',
                                          style: kTextStyle14(context,
                                              opacity: 0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // width: double.infinity,
                                    height: bodyHeight *
                                        (32 /
                                            kDeviceHeight), // same height you used
                                    child: Row(
                                      children: [
                                        Container(
                                          width:
                                              bodyWidth * (71 / kDeviceWidth),
                                          height:
                                              bodyHeight * (32 / kDeviceHeight),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: bodyWidth *
                                                  (8 / kDeviceWidth)),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                8), // Rounded corners
                                            border: Border.all(
                                                color: Color(0xff303030)
                                                    .withAlpha((0.08 * 255)
                                                        .round())), // Optional border
                                          ),
                                          child: DropdownButton<String>(
                                            isExpanded:
                                                true, // ✅ prevents internal overflow
                                            value:
                                                options.contains(dropdownValue)
                                                    ? dropdownValue
                                                    : null,
                                            icon: SvgPicture.asset(
                                              'assets/images/angle_down.svg',
                                              width: bodyWidth *
                                                  (14 / kDeviceWidth),
                                              height: bodyWidth *
                                                  (14 / kDeviceHeight),
                                            ),
                                            iconSize:
                                                0, // set to 0 to avoid interference

                                            // Selected item style
                                            dropdownColor: Colors
                                                .white, // Background color of dropdown items
                                            underline: SizedBox
                                                .shrink(), // Remove underline // Dropdown icon
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValue = newValue!;
                                              });
                                            },
                                            items: options.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: kTextStyle12(context,
                                                      weight: FontWeight.w600),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: bodyWidth * (8 / kDeviceWidth),
                                        ),
                                        SizedBox(
                                          width:
                                              bodyWidth * (32 / kDeviceWidth),
                                          height: double.infinity,
                                          child: Container(
                                            // width: bodyWidth * (32 / kDeviceWidth),
                                            // height:
                                            //     bodyHeight * (32 / kDeviceHeight),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // Rounded corners
                                              border: Border.all(
                                                  color: Color(0xff303030)
                                                      .withAlpha((0.08 * 255)
                                                          .round())), // Optional border
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: bodyWidth *
                                                      (6 / kDeviceWidth)),
                                              child: SvgPicture.asset(
                                                'assets/images/magnifying_glass.svg',
                                                width: bodyWidth *
                                                    (15.83 / kDeviceWidth),
                                                height: bodyWidth *
                                                    (15.83 / kDeviceWidth),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // 1 download, share
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: bodyHeight * (8 / kDeviceHeight),
                          ),

                          // 영수증 Card
                          RepaintBoundary(
                              key: _containerKey,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    width: bodyWidth * (281 / kDeviceWidth),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xFFDDDDDD),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(children: [
                                      // 1 share download
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                bodyWidth * (20 / kDeviceWidth),
                                            vertical: bodyHeight *
                                                (20 / kDeviceHeight)),
                                        child: Visibility(
                                          visible: !hideIcons,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  height: bodyHeight *
                                                      (32 / kDeviceHeight),
                                                  width: bodyWidth *
                                                      (32 / kDeviceWidth),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFDDDDDD),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    '${_currentIndex + 1}',
                                                    style: kTextStyle14(context,
                                                        weight:
                                                            FontWeight.w700),
                                                  ))),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: _saveToGallery,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      height: bodyHeight *
                                                          (32 / kDeviceHeight),
                                                      width: bodyWidth *
                                                          (32 / kDeviceWidth),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFDDDDDD),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/download_icon.svg',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: bodyWidth *
                                                        (8 / kDeviceWidth),
                                                  ),
                                                  GestureDetector(
                                                    onTap:
                                                        _shareRepaintBoundary,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      height: bodyHeight *
                                                          (32 / kDeviceHeight),
                                                      width: bodyWidth *
                                                          (32 / kDeviceWidth),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFDDDDDD),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/share_icon.svg',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          // why do I love you
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: bodyWidth *
                                                    (20 / kDeviceWidth),
                                                vertical: bodyHeight *
                                                    (12 / kDeviceHeight)),
                                            child: Container(
                                              height: bodyHeight *
                                                  (120 / kDeviceHeight),
                                              width: bodyWidth *
                                                  (241 / kDeviceWidth),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/black_clover_mypage.svg',
                                                  ),
                                                  Text(
                                                    receipt['title'] ?? '',
                                                    style: kTextStyle16(context,
                                                        weight:
                                                            FontWeight.w800),
                                                  ),
                                                  Text(
                                                    receipt['author'] ?? '',
                                                    style: kTextStyle12(context,
                                                        weight:
                                                            FontWeight.w800),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          // review summary
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: bodyWidth *
                                                    (20 / kDeviceWidth)),
                                            child: Container(
                                              height: bodyHeight *
                                                  (87 / kDeviceHeight),
                                              width: bodyWidth *
                                                  (241 / kDeviceWidth),
                                              child: Text(
                                                  receipt['review'] ??
                                                      '리뷰가 없습니다.',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(height: 2)),
                                            ),
                                          ),

                                          // bar code
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: bodyHeight *
                                                    (20 / kDeviceHeight)),
                                            child: Container(
                                              height: bodyHeight *
                                                  (92 / kDeviceHeight),
                                              width: bodyWidth *
                                                  (281 / kDeviceWidth),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/barcode.svg',
                                                  ),
                                                  SizedBox(
                                                    height: bodyHeight *
                                                        (12 / kDeviceHeight),
                                                  ),
                                                  Text(
                                                      '${(receipt['startDate'] as String).replaceAll("-", ".")} - ${(receipt['endDate'] as String).replaceAll("-", ".")} ${(receipt['duration'] / 3600).floor()} HOURS ${((receipt['duration'] % 3600) / 60).floor()} MIN')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ))),

                          SizedBox(
                            height: bodyHeight * (12 / kDeviceHeight),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: bodyWidth * (20 / kDeviceWidth),
                                vertical: bodyHeight * (8 / kDeviceHeight)),
                            child: Container(
                              height: bodyHeight * (56 / kDeviceHeight),
                              width: bodyWidth * (320 / kDeviceWidth),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      print(_currentIndex);
                                      if (_currentIndex > 0) {
                                        setState(() {
                                          _currentIndex--;
                                        });
                                      }
                                    },
                                    child: Text(
                                      '이전 기록',
                                      style: kTextStyle16(context),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0x56698f)
                                          .withAlpha((0.06 * 255).round()),
                                      foregroundColor: Color(0xff303030),
                                      minimumSize: Size(
                                          bodyWidth * (156 / kDeviceWidth),
                                          bodyHeight *
                                              (56 / kDeviceHeight)), // 너비와 높이
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              bodyWidth * (6 / kDeviceWidth),
                                          vertical:
                                              bodyHeight * (8 / kDeviceHeight)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      print(_currentIndex);
                                      if (_currentIndex <
                                          _bookReceipts.length - 1) {
                                        setState(() {
                                          _currentIndex++;
                                        });
                                      }
                                    },
                                    child: Text(
                                      '다음 기록',
                                      style: kTextStyle16(context,
                                          color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xff303030),
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(
                                          bodyWidth * (156 / kDeviceWidth),
                                          bodyHeight *
                                              (56 / kDeviceHeight)), // 너비와 높이
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              bodyWidth * (6 / kDeviceWidth),
                                          vertical:
                                              bodyHeight * (8 / kDeviceHeight)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ])))));
  }
}
