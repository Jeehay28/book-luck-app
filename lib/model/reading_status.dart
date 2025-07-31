enum ReadingStatus {
  reading,
  wishlist,
  finished,
  search,
  select,
}

extension ReadingStatusExtension on ReadingStatus {
  /// UI label
  String get label {
    switch (this) {
      case ReadingStatus.reading:
        return '읽는 중'; // consistent display
      case ReadingStatus.wishlist:
        return '위시리스트';
      case ReadingStatus.finished:
        return '다 읽은 책';
      case ReadingStatus.search:
        return '책 찾기';
      case ReadingStatus.select:
        return '책 선택하기';
    }
  }

  /// Accept various strings and map them back to enum
  static ReadingStatus from(String value) {
    switch (value.trim().replaceAll(' ', '')) {
      case '읽는중':
        return ReadingStatus.reading;
      case '위시리스트':
        return ReadingStatus.wishlist;
      case '다읽은책':
        return ReadingStatus.finished;
      case '책찾기':
        return ReadingStatus.search;
      case '책선택하기':
        return ReadingStatus.select;
      default:
        throw ArgumentError('Unknown reading status: $value');
    }
  }
}
