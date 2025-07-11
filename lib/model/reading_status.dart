enum ReadingStatus {
  reading,
  wishlist,
  finished,
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
      default:
        throw ArgumentError('Unknown reading status: $value');
    }
  }
}
