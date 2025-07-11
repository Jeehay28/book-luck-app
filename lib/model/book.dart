class Book {
  final String title;
  final String image;
  final String isbn;
  final String author;
  bool favorite;

  Book({
    required this.title,
    required this.image,
    required this.isbn,
    required this.author,
    this.favorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      isbn: json['isbn'] ?? '',
      author: json['author'] ?? '저자 정보 없음',
      favorite: false, // 서버에 없으므로 앱에서 기본값
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'isbn': isbn,
        'author': author,
        'favorite': favorite,
      };
}
