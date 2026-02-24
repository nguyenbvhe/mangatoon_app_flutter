import 'package:flutter/material.dart';
import '../models/comic_model.dart'; // Đảm bảo đường dẫn này đúng

class ChapterReaderScreen extends StatelessWidget {
  final Comic comic;
  final Chapter chapter;

  const ChapterReaderScreen({
    super.key,
    required this.comic,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comic.title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Chương ${chapter.chapterNumber}: ${chapter.title}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: chapter.pages.length,
        itemBuilder: (context, index) {
          final page = chapter.pages[index];
          return Image.network(
            page.imageUrl, 
            fit: BoxFit.fitWidth, // SỬA Ở ĐÂY: Đổi từ width thành fitWidth
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox( // SỬA Ở ĐÂY: Đổi Container thành SizedBox
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.orange,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey[900],
              child: const Icon(Icons.broken_image, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}