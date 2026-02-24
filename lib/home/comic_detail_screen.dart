import 'package:flutter/material.dart';
import '../models/comic_model.dart';
import 'chapter_reader_screen.dart'; // Đảm bảo bạn đã có file màn hình đọc truyện này

class ComicDetailScreen extends StatelessWidget {
  final Comic comic;

  const ComicDetailScreen({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Cho phép nội dung tràn lên khu vực thanh trạng thái (AppBar) để làm hiệu ứng ảnh nền
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Nền trong suốt
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // 1. Lớp dưới cùng: Ảnh nền được phóng to và làm tối đi
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(comic.coverImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.7), // Phủ một lớp đen mờ 70%
            ),
          ),
          
          // 2. Lớp trên cùng: Nội dung truyện có thể cuộn
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80), // Chừa chỗ cho nút Đọc Ngay ở dưới
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(),
                  const SizedBox(height: 20),
                  _buildStatsRow(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const Divider(thickness: 8, color: Color(0xFFF5F5F5)), // Dải phân cách xám
                  _buildChapterList(context),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // 3. Thanh công cụ cố định ở dưới cùng
      bottomSheet: _buildBottomAction(context),
    );
  }

  // Phân vùng 1: Ảnh bìa nhỏ, Tên truyện, Tác giả
  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh bìa chính
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              comic.coverImage,
              width: 110,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(width: 110, height: 150, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          // Thông tin chữ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comic.title,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tác giả: ${comic.author}",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Trạng thái: ${comic.status}",
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Hiển thị Thể loại (Genres)
                Wrap(
                  spacing: 8,
                  children: comic.genres.map((genre) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(genre, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  )).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Phân vùng 2: Thống kê Đánh giá & Lượt xem
  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Bo góc trên
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(Icons.star, Colors.orange, "${comic.rating}", "Đánh giá"),
          _buildStatItem(Icons.remove_red_eye, Colors.blue, "${comic.viewCount}", "Lượt xem"),
          _buildStatItem(Icons.favorite, Colors.red, "12.5K", "Yêu thích"),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, Color iconColor, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // Phân vùng 3: Tóm tắt truyện
  Widget _buildDescription() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tóm tắt", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            comic.description,
            style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Phân vùng 4: Danh sách Chương
  Widget _buildChapterList(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Danh sách chương", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Cập nhật tới chương ${comic.chapters.length}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          comic.chapters.isEmpty 
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: Text("Truyện đang được cập nhật chương mới...", style: TextStyle(color: Colors.grey))),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comic.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = comic.chapters[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Chương ${chapter.chapterNumber}: ${chapter.title}"),
                    trailing: chapter.isPremium 
                      ? const Icon(Icons.lock, color: Colors.orange, size: 20) 
                      : const Text("Miễn phí", style: TextStyle(color: Colors.green, fontSize: 12)),
                    onTap: () {
                      // Chuyển sang màn hình đọc truyện khi bấm vào chương
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterReaderScreen(comic: comic, chapter: chapter),
                        ),
                      );
                    },
                  );
                },
              ),
        ],
      ),
    );
  }

  // Phân vùng 5: Thanh Bottom Action (Nút Đọc Ngay)
  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.grey, size: 30),
            onPressed: () {
              // TODO: Logic thêm vào mục Yêu thích
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (comic.chapters.isNotEmpty) {
                  // Mặc định đọc chương đầu tiên (hoặc chương đang đọc dở)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChapterReaderScreen(comic: comic, chapter: comic.chapters[0]),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Truyện chưa có chương nào!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Màu chủ đạo
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text("ĐỌC NGAY", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}