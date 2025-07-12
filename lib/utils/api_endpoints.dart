class ApiEndpoints {
  static const String base = 'http://43.202.122.137';
  static const String base8080 = 'http://43.202.122.137:8080';

  static const String getAllBooks = '$base/books/getAllBooks';
  static const String addToFavorites = '$base/books/addToFavorites';
  static const String getRandomQuote = '$base8080/phrases/getRandomPhrase';
  static const String getQuotes = '$base/phrases/getPhrases';

  // Dynamic URL
  static String userFavoritesDetails(String userId) =>
      '$base/users/$userId/favorites/details';

  static String deleteBookFromWishlist(String userId, String bookId) =>
      '$base/users/$userId/favorites/$bookId';

  static String searchBooks(String search) =>
      '$base/books/getApiBooks?keyword=$search';
}
