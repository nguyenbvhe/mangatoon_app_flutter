import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const WelcomeScreen({super.key, required this.onLogin, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Xác thực", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          const Text("Chọn một trong các tùy chọn bên dưới để tiếp tục", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          
          _buildFullWidthButton("Đăng nhập", const Color(0xFFE53E3E), onLogin),
          const SizedBox(height: 15),
          _buildFullWidthButton("Đăng ký", const Color(0xFF4285F4), onRegister, isOutlined: true),
        ],
      ),
    );
  }

  Widget _buildFullWidthButton(String text, Color color, VoidCallback tap, {bool isOutlined = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: isOutlined 
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(side: BorderSide(color: color), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: tap,
            child: Text(text, style: TextStyle(color: color, fontSize: 17)),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: tap,
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 17)),
          ),
    );
  }
}