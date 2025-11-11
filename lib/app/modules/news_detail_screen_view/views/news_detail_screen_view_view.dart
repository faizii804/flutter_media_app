import 'package:flutter/material.dart';
import 'package:fourdimensions/app/modules/news_home_screen/models/news_model.dart';

class NewsDetailScreenViewView extends StatelessWidget {
  final NewsModel news;

  const NewsDetailScreenViewView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logos/logo.png',
              height: 35,
              width: 35,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            const Text(
              "4 Dimensions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),

            // News Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 6),

            // Time/Source text
            Text(
              "Published ${news.time} • 4 Dimensions Digital",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            // Description
            const Text(
              "A suicide blast rocked the federal capital on Tuesday, leaving at least 12 martyred and 30 injured outside a kachehri court building, said a spokesperson for the Pakistan Institute of Medical Sciences (PIMS). "
              "Of the 30 injured brought to the hospital, about five injured are in critical condition, the PIMS spokesperson said. "
              "Authorities have cordoned off the area and an investigation is underway. "
              "Security officials have increased vigilance around sensitive areas across the capital. "
              "Prime Minister and President have condemned the attack and expressed deep sorrow for the loss of precious lives. "
              "This tragic incident once again highlights the importance of strengthening internal security and unity among citizens to counter such acts of violence. "
              "More updates will follow as the investigation progresses. "
              "Citizens are advised to stay cautious and cooperate with law enforcement agencies.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
