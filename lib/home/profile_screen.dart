import 'package:flutter/material.dart';
import 'create_comic_screen.dart'; 
import '../login/login_screen.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'Cá nhân',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Chuyển đến màn Cài đặt
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context), // Truyền context vào đây để chuyển trang
            const SizedBox(height: 12),
            _buildWalletCard(),
            const SizedBox(height: 12),
            _buildMenuItems(context), 
          ],
        ),
      ),
    );
  }

  // Phân vùng 1: Thông tin Avatar, Tên, Email (Đã bọc GestureDetector để bấm vào được)
  Widget _buildProfileHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chuyển sang màn hình Đăng nhập khi bấm vào khu vực này
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg', // Avatar mặc định
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đăng nhập / Đăng ký', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vui lòng đăng nhập để tiếp tục', 
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey), // Icon mũi tên chỉ hướng
          ],
        ),
      ),
    );
  }

  // Phân vùng 2: Thẻ hiển thị số dư và nút Nạp tiền
  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orangeAccent, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Số dư của bạn',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.monetization_on, color: Colors.yellowAccent, size: 24),
                  SizedBox(width: 8),
                  Text(
                    '1,250 Xu', 
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Mở màn hình Nạp Xu
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('NẠP THÊM', style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // Phân vùng 3: Danh sách các tính năng
  Widget _buildMenuItems(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildListTile(
            Icons.edit_document, 
            'Đăng truyện mới', 
            Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateComicScreen()),
              );
            },
          ),
          const Divider(height: 1),
          _buildListTile(Icons.history, 'Lịch sử đọc', Colors.blue),
          _buildListTile(Icons.favorite_border, 'Truyện yêu thích', Colors.red), 
          _buildListTile(Icons.lock_open, 'Lịch sử mở khóa', Colors.orange), 
          _buildListTile(Icons.comment, 'Bình luận của tôi', Colors.green), 
          const Divider(height: 1),
          _buildListTile(Icons.help_outline, 'Trung tâm trợ giúp', Colors.grey),
          _buildListTile(Icons.logout, 'Đăng xuất', Colors.black54, isLogout: true),
        ],
      ),
    );
  }

  // Widget dùng chung để tạo từng dòng menu
  Widget _buildListTile(IconData icon, String title, Color iconColor, {bool isLogout = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          color: isLogout ? Colors.red : Colors.black87,
        ),
      ),
      trailing: isLogout ? null : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap ?? () {
        // TODO: Xử lý mặc định nếu chưa truyền onTap
      },
    );
  }
}