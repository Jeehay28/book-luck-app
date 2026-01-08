import 'package:flutter/material.dart';
import 'package:book_luck_app_demo/extensions/context_extensions.dart';
import 'package:book_luck_app_demo/styles/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import '../services/networking.dart';
import '../utils/api_endpoints.dart';
import '../utils/constants.dart';
import 'package:book_luck_app_demo/widgets/reading_capsule_fl_chart.dart';
import 'package:book_luck_app_demo/widgets/monthly_reading_line_chart.dart';

class BookLuckStampsScreen extends StatefulWidget {
  const BookLuckStampsScreen({super.key});

  @override
  State<BookLuckStampsScreen> createState() => _BookLuckStampsScreenState();
}

class _BookLuckStampsScreenState extends State<BookLuckStampsScreen> {
  List<Map<String, dynamic>> _badgeData = [];
  List<MonthlyReadingData> _readingMonthlyData = [];
  List<ReadingData> _readingTimeDataLast7Days = [];

  int currentPage = 0;
  static const int itemsPerPage = 9;

  final readingTimeDataWeekly = [
    ReadingData('일', 0.8),
    ReadingData('월', 2.3),
    ReadingData('화', 2.5),
    ReadingData('수', 0.4),
    ReadingData('목', 0.3),
    ReadingData('금', 0.0),
    ReadingData('토', 0.0),
  ];

  List<Map<String, dynamic>> get currentPageItems {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage < _badgeData.length)
        ? startIndex + itemsPerPage
        : _badgeData.length;

    return _badgeData.sublist(startIndex, endIndex);
  }

  Future<void> getYearlyStats(String userId, int currentYear) async {
    try {
      var url = ApiEndpoints.getYearlyStats(userId, currentYear);
      NetworkHelper networkHelper = NetworkHelper(url);
      var result = await networkHelper.getData();

      if (result == null) {
        print('getYearlyStats: response is null');
        return;
      }

      print("server raw result: $result");

      // 👇 Here is the real fix
      if (result is Map && result['data'] is List) {
        final List monthlyList = result['data'];

        final yearlyStats = monthlyList
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .map((e) => MonthlyReadingData(
                  int.parse(e['month']), // month comes as "1", "2"...
                  (e['minutes'] as num).toDouble(), // keep as minutes for now
                ))
            .toList();

        if (!mounted) return;

        setState(() {
          _readingMonthlyData = yearlyStats;
        });

        print("converted chart data 👇");
        for (var e in _readingMonthlyData) {
          print("month: ${e.month}, minutes: ${e.minutes}");
        }

        return;
      }

      print(
          'getYearlyStats: unexpected response type'); // ← you were hitting this before
    } catch (err) {
      print('Error during getYearlyStats: $err');
    }
  }

  Future<void> getWeeklyStats(String userId) async {
    try {
      var url = ApiEndpoints.getWeeklyStats(userId);
      NetworkHelper networkHelper = NetworkHelper(url);
      var result = await networkHelper.getData();

      if (result == null) {
        print('getWeeklyStats: response is null');
        return;
      }

      print("server raw result: $result");

      if (result is List) {
        final weeklyStats = result
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

        if (!mounted) return;

        if (weeklyStats.isNotEmpty) {
          // Convert Map → ReadingData
          final convertedWeeklyStats =
              weeklyStats.map((map) => ReadingData.fromJson(map)).toList();

          setState(() {
            _readingTimeDataLast7Days = convertedWeeklyStats;
          });
        }
        return;
      }

      print(
          'getWeeklyStats: unexpected response type'); // ← you were hitting this before
    } catch (err) {
      print('Error during getYearlyStats: $err');
    }
  }

  Future<void> getBookStamps(String userId) async {
    try {
      var url = ApiEndpoints.getBookStamps(userId);
      NetworkHelper networkHelper = NetworkHelper(url);
      var result = await networkHelper.getData();

      if (result == null) {
        print('getBookStamps: response is null');
        return;
      } else {
        setState(() {
          _badgeData = (result as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });

        print("server raw result: $result");
      }
    } catch (err) {
      print('Error during getBookStamps: $err');
    }
  }

  @override
  void initState() {
    super.initState();
    getYearlyStats('1', DateTime.now().year);
    getWeeklyStats('1');
    getBookStamps('1');
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.bodyHeight;
    final bodyWidth = context.bodyWidth;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: bodyWidth * (20 / kDeviceWidth),
              vertical: bodyHeight * (14 / kDeviceHeight)),
          child: Container(
            width: bodyWidth * (360 / kDeviceWidth),
            height: bodyHeight * (76 / kDeviceHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '북럭 도감',
                  style: kTextStyle20(context, weight: FontWeight.w600),
                ),
                Text(
                  '책을 읽으며 새로운 북럭이 찾아보세요',
                  style: kTextStyle14(context,
                      weight: FontWeight.w500, opacity: 0.4),
                )
              ],
            ),
          ),
        ),
        // 북럭 미션
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: bodyWidth * (20 / kDeviceWidth),
              vertical: bodyHeight * (12 / kDeviceHeight)),
          child: Container(
            width: bodyWidth * (320 / kDeviceWidth),
            height: bodyHeight * (460 / kDeviceHeight),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0x1F303030))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: bodyHeight * (20 / kDeviceHeight),
                ),
                SvgPicture.asset(
                  'assets/images/book_luck_mission.svg',
                  // width: bodyWidth * (24 / kDeviceWidth),
                  height: bodyHeight * (14 / kDeviceHeight),
                ),
                const SizedBox(height: 16),
                Column(
                  children: List.generate(
                    (currentPageItems.length / 3).ceil(), // rows per page
                    (rowIndex) {
                      final start = rowIndex * 3;
                      final end = (start + 3 < currentPageItems.length)
                          ? start + 3
                          : currentPageItems.length;

                      final rowItems = currentPageItems.sublist(start, end);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: rowItems.map((item) {
                          final isActive = item['active'] as bool;
                          return Container(
                            height: bodyHeight * (112 / kDeviceHeight),
                            width: bodyWidth * (96 / kDeviceWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  isActive
                                      ? 'assets/images/small_green_clover.svg'
                                      : 'assets/images/small_clover.svg',
                                  width: bodyWidth * (62 / kDeviceWidth),
                                  height: bodyHeight * (62 / kDeviceHeight),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['title'] as String,
                                  textAlign: TextAlign.center,
                                  style: kTextStyle12(
                                    context,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                    height: 56 * (bodyHeight / kDeviceHeight),
                    width: 288 * (bodyWidth / kDeviceWidth),
                    decoration: BoxDecoration(
                      color: Color(0x0F56698F),
                      borderRadius: BorderRadius.circular(8),
                      // border:
                      //     Border.all(color: Color(0x1F303030))
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/lock.svg',
                          width: bodyWidth * (15 / kDeviceWidth),
                          height: bodyHeight * (18.33 / kDeviceHeight),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'NEXT STAGE',
                          style: kTextStyle14(context, opacity: 0.6),
                        )
                      ],
                    ))),
              ],
            ),
          ),
        ),
        // Bar
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: bodyHeight * (12 / kDeviceHeight)),
          child: Container(
            height: bodyHeight * (8 / kDeviceHeight),
            decoration:
                BoxDecoration(color: Color(0xFF56698F).withOpacity(0.04)),
          ),
        ),
        Container(
          height: bodyHeight * (257.33 / kDeviceHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/open_book.svg',
                width: bodyWidth * (24 / kDeviceWidth),
                height: bodyHeight * (24 / kDeviceHeight),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '64',
                      style: kTextStyle20(context).copyWith(
                        color:
                            Color(0xffEA5D29), // <-- highlight only this part
                      ),
                    ),
                    TextSpan(
                      text: '분의 독서',
                      style: kTextStyle20(context),
                    ),
                  ],
                ),
              ),
              Text(
                '최근 7일 독서 기록',
                style: kTextStyle14(context,
                    opacity: 0.4, weight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: bodyHeight * (149.33 / kDeviceHeight),
                width: bodyWidth * (320 / kDeviceWidth),
                child: ReadingCapsuleFlChart(data: _readingTimeDataLast7Days),
              ),
            ],
          ),
        ),

        Container(
            height: bodyHeight * (277.33 / kDeviceHeight),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: bodyHeight * (48 / kDeviceHeight),
                      width: bodyWidth * (320 / kDeviceWidth),
                      decoration: BoxDecoration(
                        color: Color(0xffebeef5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: bodyHeight * (40 / kDeviceHeight),
                            width: bodyWidth * (152 / kDeviceWidth),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                              '주간',
                              style: kTextStyle14(context,
                                  weight: FontWeight.w700),
                            )),
                          ),
                          Container(
                            height: bodyHeight * (40 / kDeviceHeight),
                            width: bodyWidth * (152 / kDeviceWidth),
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(8),
                            // ),
                            child: Center(
                                child: Text(
                              '월간',
                              style: kTextStyle14(context,
                                  weight: FontWeight.w700),
                            )),
                          )
                        ],
                      )),
                  Container(
                    height: bodyHeight * (189.33 / kDeviceHeight),
                    width: bodyWidth * (320 / kDeviceWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '최근 7일 독서 기록',
                                style: kTextStyle16(context,
                                    weight: FontWeight.w700),
                              )
                            ]),
                        Container(
                          width: bodyWidth * (320 / kDeviceWidth),
                          height: bodyHeight * (149.33 / kDeviceHeight),
                          child: ReadingCapsuleFlChart(
                              data: readingTimeDataWeekly),
                        )
                      ],
                    ),
                  )
                ])),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: bodyHeight * (12 / kDeviceHeight)),
          child: Container(
            height: bodyHeight * (8 / kDeviceHeight),
            decoration:
                BoxDecoration(color: Color(0xFF56698F).withOpacity(0.04)),
          ),
        ),
        Container(
          height: bodyHeight * (305 / kDeviceHeight),
          child: Container(
            height: bodyHeight * (197 / kDeviceHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/open_book.svg',
                  width: bodyWidth * (24 / kDeviceWidth),
                  height: bodyHeight * (24 / kDeviceHeight),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '64',
                        style: kTextStyle20(context).copyWith(
                          color:
                              Color(0xffEA5D29), // <-- highlight only this part
                        ),
                      ),
                      TextSpan(
                        text: '시간 ',
                        style: kTextStyle20(context),
                      ),
                      TextSpan(
                        text: '32',
                        style: kTextStyle20(context).copyWith(
                          color:
                              Color(0xffEA5D29), // <-- highlight only this part
                        ),
                      ),
                      TextSpan(
                        text: '분 독서 ',
                        style: kTextStyle20(context),
                      ),
                    ],
                  ),
                ),
                Text(
                  '월별 독서 시간',
                  style: kTextStyle14(context,
                      opacity: 0.4, weight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: bodyHeight * (149.33 / kDeviceHeight),
                  width: bodyWidth * (320 / kDeviceWidth),
                  child: MonthlyReadingLineChart(data: _readingMonthlyData),
                )
              ],
            ),
          ),
        ),
        // Bar
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: bodyHeight * (12 / kDeviceHeight)),
          child: Container(
            height: bodyHeight * (8 / kDeviceHeight),
            decoration:
                BoxDecoration(color: Color(0xFF56698F).withOpacity(0.04)),
          ),
        ),
        Container(
          height: bodyHeight * (248 / kDeviceHeight),
          child: Container(
            height: bodyHeight * (257.33 / kDeviceHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/open_book.svg',
                  width: bodyWidth * (24 / kDeviceWidth),
                  height: bodyHeight * (24 / kDeviceHeight),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '책을 펼친 날의 기록 ',
                        style: kTextStyle20(context),
                      ),
                      TextSpan(
                        text: '326',
                        style: kTextStyle20(context).copyWith(
                          color:
                              Color(0xffEA5D29), // <-- highlight only this part
                        ),
                      ),
                      TextSpan(
                        text: '일',
                        style: kTextStyle20(context),
                      ),
                    ],
                  ),
                ),
                Text(
                  '누적 독서 시간',
                  style: kTextStyle14(context,
                      opacity: 0.4, weight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: bodyHeight * (120 / kDeviceHeight),
                  width: bodyWidth * (320 / kDeviceWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0x1F303030), width: 1),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '123',
                            style: kTextStyle20(context).copyWith(
                              color: Color(
                                  0xffEA5D29), // <-- highlight only this part
                            ),
                          ),
                          TextSpan(
                            text: '시간 ',
                            style: kTextStyle20(context),
                          ),
                          TextSpan(
                            text: '32',
                            style: kTextStyle20(context).copyWith(
                              color: Color(
                                  0xFFFFB800), // <-- highlight only this part
                            ),
                          ),
                          TextSpan(
                            text: '분 ',
                            style: kTextStyle20(context),
                          ),
                          TextSpan(
                            text: '17',
                            style: kTextStyle20(context).copyWith(
                              color: Color(
                                  0xFF15B67C), // <-- highlight only this part
                            ),
                          ),
                          TextSpan(
                            text: '초',
                            style: kTextStyle20(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
