import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onNavigateToLogin;

  const RegisterScreen({super.key, required this.onNavigateToLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding cân đối để card trông thanh thoát
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon phía trên với hiệu ứng đổ bóng màu nhạt
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF7B6AD0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_add_alt_1_rounded, 
              color: Color(0xFF7B6AD0), 
              size: 32
            ),
          ),
          const SizedBox(height: 16),
          
          // Tiêu đề chính
          const Text(
            "Create Account", 
            style: TextStyle(
              fontSize: 26, 
              fontWeight: FontWeight.w800, 
              color: Color(0xFF2D3142), 
              letterSpacing: -0.5
            )
          ),
          const SizedBox(height: 4),
          const Text(
            "Bắt đầu hành trình của bạn ngay hôm nay", 
            style: TextStyle(color: Colors.black45, fontSize: 13)
          ),
          const SizedBox(height: 30),
          
          // Các ô nhập liệu thiết kế hiện đại (Không viền cứng)
          _buildCustomField("Email Address", Icons.alternate_email_rounded, false),
          const SizedBox(height: 12),
          _buildCustomField("Password", Icons.lock_open_rounded, true),
          const SizedBox(height: 12),
          _buildCustomField("Confirm Password", Icons.verified_user_outlined, true),
          
          const SizedBox(height: 24),
          
          // Nút Đăng ký với hiệu ứng Gradient và Shadow màu
          _buildLuxuryButton("Sign Up", Icons.rocket_launch_rounded, () {
            // Xử lý logic đăng ký tại đây
          }),
          
          const SizedBox(height: 24),
          
          // Dòng điều hướng về Login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Đã có tài khoản? ", 
                style: TextStyle(color: Colors.black54, fontSize: 13)
              ),
              GestureDetector(
                onTap: onNavigateToLogin,
                child: const Text(
                  "Đăng nhập", 
                  style: TextStyle(
                    color: Color(0xFF7B6AD0), 
                    fontWeight: FontWeight.bold, 
                    fontSize: 13
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- HÀM TẠO Ô NHẬP LIỆU (CUSTOM TEXTFIELD) ---
  Widget _buildCustomField(String hint, IconData icon, bool isPass) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F9), // Màu nền xám nhạt tinh tế
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        obscureText: isPass,
        style: const TextStyle(fontSize: 14, color: Color(0xFF2D3142)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF7B6AD0), size: 20),
          suffixIcon: isPass 
              ? const Icon(Icons.visibility_off_outlined, color: Colors.black12, size: 18) 
              : null,
          border: InputBorder.none, // Loại bỏ viền thô cứng
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        ),
      ),
    );
  }

  // --- HÀM TẠO NÚT BẤM SANG TRỌNG (LUXURY BUTTON) ---
  Widget _buildLuxuryButton(String text, IconData icon, VoidCallback tap) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF7B6AD0), Color(0xFF9283E0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B6AD0).withOpacity(0.35),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, 
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: tap,
        icon: Icon(icon, color: Colors.white, size: 18),
        label: Text(
          text, 
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5
          )
        ),
      ),
    );
  }
}