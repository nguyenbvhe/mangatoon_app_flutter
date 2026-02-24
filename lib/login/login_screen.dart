import 'package:flutter/material.dart';
import 'register_screen.dart'; // Đảm bảo import đúng file đăng ký của bạn

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6359A5)), // Nút back màu tím
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopIcon(Icons.person_outline_rounded),
              const SizedBox(height: 20),
              const Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6359A5),
                ),
              ),
              const Text(
                "Chào mừng bạn quay trở lại",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 35),
              
              _buildInputField("Email *", Icons.email_outlined),
              const SizedBox(height: 20),
              _buildInputField(
                "Mật khẩu *",
                Icons.lock_outline,
                isPassword: true,
              ),
              
              // Quên mật khẩu
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Xử lý quên mật khẩu
                  },
                  child: const Text(
                    "Quên mật khẩu?",
                    style: TextStyle(color: Color(0xFF7B6AD0), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              _buildPrimaryButton(
                "Đăng nhập",
                Icons.login_rounded,
                () {
                  // TODO: Xử lý đăng nhập thành công
                  Navigator.pop(context); // Tạm thời đăng nhập xong thì quay về Profile
                },
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text("hoặc", style: TextStyle(color: Colors.grey)),
              ),
              
              _buildSocialButton(
                "Đăng nhập với Google",
                Icons.g_mobiledata,
              ),
              
              const SizedBox(height: 20),
              
              // Chuyển sang màn Đăng ký
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản?"),
                  TextButton(
                    onPressed: () {
                      // Chuyển sang màn RegisterScreen bạn vừa tạo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(
                            // Truyền các hàm callback mà RegisterScreen yêu cầu
                            onNavigateToLogin: () {
                              Navigator.pop(context); // Trở về màn Login
                            },
                            onRegisterSuccess: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đăng ký thành công! Vui lòng đăng nhập.')),
                              );
                              Navigator.pop(context); // Thành công cũng về màn Login
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Đăng ký ngay",
                      style: TextStyle(
                        color: Color(0xFF7B6AD0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Các Widget dùng chung (Sao chép từ màn Register của bạn cho đồng bộ) ---

  Widget _buildPrimaryButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B6AD0), Color(0xFF6359A5)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF7B6AD0),
      ),
      child: Icon(icon, color: Colors.white, size: 35),
    );
  }

  Widget _buildInputField(String label, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF7B6AD0)),
            suffixIcon: isPassword ? const Icon(Icons.visibility_outlined, size: 20) : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String text, IconData icon) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: Color(0xFF4285F4)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: const Color(0xFF4285F4), size: 30),
      label: Text(text, style: const TextStyle(color: Color(0xFF4285F4))),
    );
  }
}