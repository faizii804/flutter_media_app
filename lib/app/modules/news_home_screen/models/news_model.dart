class NewsModel {
  final String title;
  final String imageUrl;
  final String time;
  final String description;
  final bool isFeatured;

  NewsModel({
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.description,
    this.isFeatured = false,
  });
}
