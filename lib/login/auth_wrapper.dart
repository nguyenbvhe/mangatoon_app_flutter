import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Nền màu tím chủ đạo
          Container(
            color: const Color(0xFF8E79D1),
          ),
          // Các vòng tròn mờ trang trí
          Positioned(top: 150, left: 50, child: _buildBlurCircle(100)),
          Positioned(bottom: 50, right: 80, child: _buildBlurCircle(120)),
          Positioned(top: 400, right: -30, child: _buildBlurCircle(80)),
          
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50), // Bo góc cực lớn như ảnh
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 40,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.12),
      ),
    );
  }
}