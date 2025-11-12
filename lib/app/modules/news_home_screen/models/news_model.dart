import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final bool isFeatured;
  final Timestamp timestamp; // Firestore Timestamp

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
    this.isFeatured = false,
  });
}
