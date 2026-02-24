import 'package:flutter/material.dart';
import '../models/comic_model.dart';
 import 'comic_detail_screen.dart'; // Bỏ comment dòng này khi bạn có màn detail

class ComicsScreen extends StatefulWidget {
  // Nhận danh sách truyện từ HomePage
  final List<Comic> comics;

  const ComicsScreen({super.key, required this.comics});

  @override
  State<ComicsScreen> createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  // Các biến để lưu trạng thái lọc
  String selectedGenre = "Toàn bộ";
  String selectedStatus = "Hot nhất";

  @override
  Widget build(BuildContext context) {
    // Logic lọc truyện: Lấy danh sách truyện từ widget.comics và lọc theo thể loại
    List<Comic> displayedComics = widget.comics.where((comic) {
      bool matchesGenre = selectedGenre == "Toàn bộ" || comic.genres.contains(selectedGenre);
      // Bạn có thể thêm logic lọc theo selectedStatus ở đây sau này
      return matchesGenre;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Truyện tranh", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Khu vực bộ lọc
            _buildFilterSection(),
            const Divider(thickness: 1, color: Colors.black12),
            
            // Nếu không có truyện nào khớp, hiển thị thông báo
            displayedComics.isEmpty 
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text("Không tìm thấy truyện phù hợp!", style: TextStyle(color: Colors.grey)),
                )
              : _buildComicGrid(displayedComics), // Truyền danh sách đã lọc vào Grid
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      children: [
        _buildFilterRow(
          "Kênh", 
          ["Toàn bộ", "Hành động", "Truyện hài", "Kinh dị", "Huyền huyễn", "Bí ẩn", "Mạo hiểm", "Xuyên không", "Ngôn tình", "Romance", "School", "Fantasy"], 
          selectedGenre, 
          (val) => setState(() => selectedGenre = val)
        ),
        _buildFilterRow(
          "Trạng thái", 
          ["Hot nhất", "Mới nhất", "Đã Full"], 
          selectedStatus, 
          (val) => setState(() => selectedStatus = val)
        ),
      ],
    );
  }

  Widget _buildFilterRow(String title, List<String> options, String current, Function(String) onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          ),
          Expanded(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: options.map((option) {
                final isSelected = option == current;
                return GestureDetector(
                  onTap: () => onSelect(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.transparent, // Đổi sang màu cam cho đồng bộ
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComicGrid(List<Comic> comicsToShow) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65, // Tỉ lệ khung hình (Rộng/Cao)
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        itemCount: comicsToShow.length, // Cập nhật số lượng động
        itemBuilder: (context, index) {
          final comic = comicsToShow[index]; // Lấy truyện tương ứng

          return GestureDetector(
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ComicDetailScreen(comic: comic),
    ),
  );
},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      comic.coverImage, // Dùng ảnh thật từ dữ liệu
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (c, e, s) => Container(color: Colors.grey[300]), // Hiển thị nền xám nếu lỗi ảnh
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  comic.title, // Tên truyện thật
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                ),
                Text(
                  "${comic.genres.isNotEmpty ? comic.genres.first : 'Khác'} | ${comic.rating}⭐", // Dữ liệu thật
                  style: const TextStyle(color: Colors.grey, fontSize: 12)
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}