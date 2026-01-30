class ApiEndpoints {
  static const String base = 'https://api.bookluck.org';
  static const String base8080 = 'https://43.202.122.137:8080';

  static const String getAllBooks = '$base/books/getAllBooks';
  static const String addToFavorites = '$base/books/addToFavorites';
  static const String recordBooks = '$base/books/record';
  static const String getRandomQuote = '$base8080/phrases/getRandomPhrase';
  static const String getQuotes = '$base/phrases/getPhrases';

  // Dynamic URL
  static String userFavoritesDetails(String userId) =>
      '$base/users/$userId/favorites/details';

  static String deleteBookFromWishlist(String userId, String bookId) =>
      '$base/users/$userId/favorites/$bookId';

  static String searchBooks(String search) =>
      '$base/books/getApiBooks?keyword=$search';

  static String getBookReviews(String userId) => '$base/users/$userId/records';

  static String getReceipts(String userId) => '$base/users/$userId/receipt';

  static String getYearlyStats(String userId, int currentYear) =>
      '$base/users/$userId/records/stats?year=$currentYear';

  static String getWeeklyStats(String userId) =>
      '$base/users/$userId/records/weekly';

  static String getBookStamps(String userId) => '$base/users/$userId/badges';

  static const startReading = '$base/books/reading/start';

  static const pauseReading = '$base/books/reading/pause';

  static const resumeReading = '$base/books/reading/resume';

  static const stopReading = '$base/books/reading/stop';

  static String getReadTime(String userId) =>
      '$base/books/reading/current/$userId';
}
