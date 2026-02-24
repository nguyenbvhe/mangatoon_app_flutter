import 'package:flutter/material.dart';

class Comic {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final String author;
  final String status;
  final List<String> genres;
  final int viewCount;
  final double rating;
  final List<Chapter> chapters; // Kết nối 1-n với Chapter

  Comic({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.author,
    required this.status,
    required this.genres,
    required this.viewCount,
    required this.rating,
    required this.chapters,
  });
}

class Chapter {
  final String id;
  final String comicId;
  final int chapterNumber;
  final String title;
  final bool isPremium;
  final int unlockPrice;
  final List<ChapterPage> pages; // Kết nối 1-n với ChapterPage

  Chapter({
    required this.id,
    required this.comicId,
    required this.chapterNumber,
    required this.title,
    required this.isPremium,
    required this.unlockPrice,
    required this.pages,
  });
}

class ChapterPage {
  final String id;
  final String chapterId;
  final int pageNumber;
  final String imageUrl;

  ChapterPage({
    required this.id,
    required this.chapterId,
    required this.pageNumber,
    required this.imageUrl,
  });
}