import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onNavigateToRegister;
  final VoidCallback onBack;

  const LoginScreen({super.key, required this.onNavigateToRegister, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon với hiệu ứng Glow mờ
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF7B6AD0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Color(0xFF7B6AD0), size: 32),
          ),
          const SizedBox(height: 16),
          const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF2D3142), letterSpacing: -0.5)),
          const Text("Đăng nhập để tiếp tục khám phá", style: TextStyle(color: Colors.black45, fontSize: 13)),
          const SizedBox(height: 28),
          
          _buildCustomField("Email Address", Icons.alternate_email_rounded, false),
          const SizedBox(height: 16),
          _buildCustomField("Password", Icons.lock_open_rounded, true),
          
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text("Quên mật khẩu?", style: TextStyle(color: Color(0xFF7B6AD0), fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 12),
          _buildLuxuryButton("Sign In", Icons.arrow_forward_rounded, () {}),
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Chưa có tài khoản? ", style: TextStyle(color: Colors.black54, fontSize: 13)),
              GestureDetector(
                onTap: onNavigateToRegister,
                child: const Text("Tạo ngay", style: TextStyle(color: Color(0xFF7B6AD0), fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomField(String hint, IconData icon, bool isPass) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF7B6AD0), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildLuxuryButton(String text, IconData icon, VoidCallback tap) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF7B6AD0), Color(0xFF9283E0)]),
        boxShadow: [BoxShadow(color: const Color(0xFF7B6AD0).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        onPressed: tap,
        icon: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        label: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}