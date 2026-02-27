import 'package:flutter/material.dart';
import 'dart:async';
import '../models/comic_model.dart';
import '../data/mock_data.dart'; 
import 'comic_detail_screen.dart';

class RecommentScreen extends StatelessWidget {
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
            const SizedBox(height: 10),
            // Gọi Widget Banner Tự Động Trượt
            _AutoScrollBanner(comics: comics, onNavigate: _navigateToDetail), 
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

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
            onTap: () => _navigateToDetail(context, comic), 
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

  Widget _buildVerticalList(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), 
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];
        return GestureDetector(
          onTap: () => _navigateToDetail(context, comic), 
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

  void _navigateToDetail(BuildContext context, Comic comic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComicDetailScreen(comic: comic),
      ),
    );
  }
}

// ==========================================
// WIDGET BANNER TỰ ĐỘNG TRƯỢT (STATEFUL WIDGET)
// ==========================================
class _AutoScrollBanner extends StatefulWidget {
  final List<Comic> comics;
  final void Function(BuildContext, Comic) onNavigate;

  const _AutoScrollBanner({required this.comics, required this.onNavigate});

  @override
  State<_AutoScrollBanner> createState() => _AutoScrollBannerState();
}

class _AutoScrollBannerState extends State<_AutoScrollBanner> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Cài đặt Timer cứ 3 giây thì tự động trượt 1 lần
    if (widget.comics.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        // Lấy toàn bộ danh sách thay vì giới hạn 5
        final maxPages = widget.comics.length;
        
        if (_currentPage < maxPages - 1) {
          _currentPage++;
        } else {
          _currentPage = 0; // Quay lại trang đầu nếu đã đến cuối
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350), 
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comics.isEmpty) return const SizedBox();
    
    // Lấy toàn bộ danh sách để hiển thị
    final maxPages = widget.comics.length;

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: maxPages,
        itemBuilder: (context, index) {
          final comic = widget.comics[index];
          return GestureDetector(
            onTap: () => widget.onNavigate(context, comic),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(comic.coverImage),
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
                  comic.title,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}