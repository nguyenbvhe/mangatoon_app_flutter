import 'package:flutter/material.dart';
import '../models/comic_model.dart';
import '../data/mock_data.dart'; 
import 'comic_detail_screen.dart';

class RecommentScreen extends StatelessWidget {
  // Nhận danh sách truyện từ bên ngoài truyền vào
  final List<Comic> comics;

  const RecommentScreen({super.key, required this.comics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Khám phá',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // TODO: Chuyển sang màn tìm kiếm
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBannerSection(context),
            const SizedBox(height: 20),
            _buildSectionTitle('🔥 Truyện Hot Trong Tuần'),
            _buildHorizontalList(context),
            const SizedBox(height: 20),
            _buildSectionTitle('✨ Có Thể Bạn Sẽ Thích'),
            _buildVerticalList(context),
          ],
        ),
      ),
    );
  }

  // 1. Banner ngang cỡ lớn
  Widget _buildBannerSection(BuildContext context) {
    if (comics.isEmpty) return const SizedBox();
    final topComic = comics.first; // Lấy tạm truyện đầu tiên làm Banner

    return GestureDetector(
      onTap: () => _navigateToDetail(context, topComic),
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(topComic.coverImage),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
        ),
        alignment: Alignment.bottomLeft,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            ),
          ),
          child: Text(
            topComic.title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Tiêu đề của từng mục (Section Title)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // 2. Danh sách cuộn ngang (Truyện Hot)
  Widget _buildHorizontalList(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: comics.length,
        itemBuilder: (context, index) {
          final comic = comics[index];
          return GestureDetector(
            onTap: () => _navigateToDetail(context, comic), // Nhấn để chuyển màn
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      comic.coverImage,
                      height: 160,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(height: 160, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    comic.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 3. Danh sách cuộn dọc (Có thể bạn sẽ thích)
  Widget _buildVerticalList(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Tắt cuộn để không đụng độ với SingleChildScrollView
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];
        return GestureDetector(
          onTap: () => _navigateToDetail(context, comic), // Nhấn để chuyển màn
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    comic.coverImage,
                    height: 100,
                    width: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(height: 100, width: 75, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comic.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comic.genres.join(', '), 
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 16),
                          const SizedBox(width: 4),
                          Text('${comic.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          const Icon(Icons.remove_red_eye, color: Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text('${comic.viewCount}', style: const TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // HÀM ĐIỀU HƯỚNG: Đã được mở khóa và đặt đúng vị trí bên trong class
  void _navigateToDetail(BuildContext context, Comic comic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComicDetailScreen(comic: comic),
      ),
    );
  }
}