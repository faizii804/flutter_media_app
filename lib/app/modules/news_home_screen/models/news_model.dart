class NewsModel {
  final String title;
  final String imageUrl;
  final String time;
  final bool isFeatured;

  NewsModel({
    required this.title,
    required this.imageUrl,
    required this.time,
    this.isFeatured = false,
  });
}
