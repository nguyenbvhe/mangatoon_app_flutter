import 'dart:ui';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng màu nền gradient nhẹ để tạo chiều sâu giống ảnh mẫu
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDEEF2), Color(0xFFF5F5F5)], // Tông hồng nhạt sang xám trắng
          ),
        ),
        child: Stack(
          children: [
            // 1. Lớp trang trí phía sau (Các vòng tròn màu)
            _buildDecorCircle(top: 100, left: -50, size: 200, color: Colors.pink.withOpacity(0.1)),
            _buildDecorCircle(bottom: 100, right: -30, size: 150, color: Colors.purple.withOpacity(0.1)),

            // 2. Lớp phủ làm mờ toàn màn hình khi có Pop-up xuất hiện
            // (Trong ảnh mẫu, nền bị làm mờ đi một chút)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),

            // 3. Nội dung chính (Pop-up trắng)
            Center(
              child: FadeInUp( // Nếu bạn có animate_do, không thì dùng Container bình thường
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Bo góc cực mạnh (Radius 30-40) đúng chất MangaToon
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nút đóng (X) ở góc trên bên phải
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, color: Colors.black, size: 28),
                        ),
                      ),
                      // Chèn widget con (Nội dung đăng nhập) vào đây
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hỗ trợ vẽ các hình tròn trang trí
  Widget _buildDecorCircle({double? top, double? left, double? right, double? bottom, required double size, required Color color}) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

// Widget giả lập hiệu ứng xuất hiện nhẹ nhàng
class FadeInUp extends StatelessWidget {
  final Widget child;
  const FadeInUp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}