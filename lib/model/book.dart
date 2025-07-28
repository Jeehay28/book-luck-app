class Book {
  final String title;
  final String image;
  final String isbn;
  final String author;
  String? description;
  bool favorite;

  Book({
    required this.title,
    required this.image,
    required this.isbn,
    required this.author,
    this.description,
    this.favorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      isbn: json['isbn'] ?? '',
      author: json['author'] ?? '저자 정보 없음',
      description: json['description'] ?? '',
      favorite: false, // 서버에 없으므로 앱에서 기본값
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'isbn': isbn,
        'author': author,
        'description': description,
        'favorite': favorite,
      };
}
