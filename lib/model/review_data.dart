import 'package:book_luck_app_demo/model/review.dart';

class ReviewData {
  final List<Review> _review = [
    Review(
        readDate: "2024.10.22",
        readTime: "18분 42초 읽음",
        content:
            "“... 그리고 또 그 사람은 우리와 같은 온전한 두 다리를 갖고 싶은 게 아니에요. 다리는 형체죠. 진정으로 가지고 싶은 건 자유로움이에요. 가고자 한다면 어디든 갈 수 있는, 자유요. 자유를 위해서는 많은 돈이 필요한 게 아니라 아주 잘 만들어진,"),
    Review(
        readDate: "2024.10.21",
        readTime: "21분 58초 읽음",
        content:
            "“... 그리고 또 그 사람은 우리와 같은 온전한 두 다리를 갖고 싶은 게 아니에요. 다리는 형체죠. 진정으로 가지고 싶은 건 자유로움이에요. 가고자 한다면 어디든 갈 수 있는, 자유요. 자유를 위해서는 많은 돈이 필요한 게 아니라 아주 잘 만들어진,"),
    Review(
        readDate: "2024.10.22",
        readTime: "26분 21초 읽음",
        content:
            "“... 그리고 또 그 사람은 우리와 같은 온전한 두 다리를 갖고 싶은 게 아니에요. 다리는 형체죠. 진정으로 가지고 싶은 건 자유로움이에요. 가고자 한다면 어디든 갈 수 있는, 자유요. 자유를 위해서는 많은 돈이 필요한 게 아니라 아주 잘 만들어진,"),
    Review(
        readDate: "2024.10.22",
        readTime: "26분 21초 읽음",
        content:
            "“... 그리고 또 그 사람은 우리와 같은 온전한 두 다리를 갖고 싶은 게 아니에요. 다리는 형체죠. 진정으로 가지고 싶은 건 자유로움이에요. 가고자 한다면 어디든 갈 수 있는, 자유요. 자유를 위해서는 많은 돈이 필요한 게 아니라 아주 잘 만들어진,"),
    Review(
        readDate: "2024.10.22",
        readTime: "26분 21초 읽음",
        content:
            "“... 그리고 또 그 사람은 우리와 같은 온전한 두 다리를 갖고 싶은 게 아니에요. 다리는 형체죠. 진정으로 가지고 싶은 건 자유로움이에요. 가고자 한다면 어디든 갈 수 있는, 자유요. 자유를 위해서는 많은 돈이 필요한 게 아니라 아주 잘 만들어진,")
  ];

  List<Review> get reviewData {
    return _review;
  }

  void addReview(Review newReview) {
    _review.add(newReview);
  }

  void updateReview(Review review) {
    print('update review');
  }

  void deleteReview(Review review) {
    _review.remove(review);
  }

  int get ReviewDataCount {
    return _review.length;
  }
}
