import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onNavigateToRegister;
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.onNavigateToRegister,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopIcon(Icons.login_rounded),
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
                "Chào mừng bạn trở lại!",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 35),
              _buildSocialButton(
                "Đăng nhập với Google",
                Icons.g_mobiledata,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text("hoặc",
                    style: TextStyle(color: Colors.grey)),
              ),
              _buildInputField("Email *", Icons.email_outlined),
              const SizedBox(height: 20),
              _buildInputField(
                "Mật khẩu *",
                Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: onNavigateToRegister,
                    child: const Text(
                      "Đăng ký",
                      style:
                          TextStyle(color: Color(0xFF7B6AD0)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Quên mật khẩu?",
                      style:
                          TextStyle(color: Color(0xFF7B6AD0)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildPrimaryButton(
                "Đăng nhập",
                Icons.login_rounded,
                onLoginSuccess,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(
      String text, IconData icon, VoidCallback onPressed) {
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

  Widget _buildInputField(
      String label, IconData icon,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 20,
              color: const Color(0xFF7B6AD0),
            ),
            suffixIcon: isPassword
                ? const Icon(Icons.visibility_outlined,
                    size: 20)
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.black12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      String text, IconData icon) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize:
            const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20),
        ),
        side: const BorderSide(
            color: Color(0xFF4285F4)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: const Color(0xFF4285F4)),
      label: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4285F4),
        ),
      ),
    );
  }
}