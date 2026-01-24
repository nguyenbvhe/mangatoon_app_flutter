import 'package:flutter/material.dart';
import 'login/auth_wrapper.dart';
import 'login/welcome_screen.dart';
import 'login/login_screen.dart';
import 'login/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Sử dụng font hệ thống hoặc Roboto để giống giao diện web
        fontFamily: 'Roboto', 
      ),
      home: const AuthNavigationCenter(),
    );
  }
}

class AuthNavigationCenter extends StatefulWidget {
  const AuthNavigationCenter({super.key});

  @override
  State<AuthNavigationCenter> createState() => _AuthNavigationCenterState();
}

class _AuthNavigationCenterState extends State<AuthNavigationCenter> {
  // Biến quản lý trạng thái màn hình hiện tại
  // 'login'   -> Màn hình đăng nhập
  // 'register'-> Màn hình đăng ký
  String _currentView = 'login';

  void _navigateTo(String view) {
    setState(() {
      _currentView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AuthWrapper chứa Background Gradient và Card trắng bo tròn
    return AuthWrapper(
      child: _buildCurrentBody(),
    );
  }

  // Hàm quyết định nội dung nào được hiển thị bên trong Card trắng
  Widget _buildCurrentBody() {
    switch (_currentView) {
      case 'login':
        return LoginScreen(
          onBack: () => {},
          onNavigateToRegister: () => _navigateTo('register'),
        );
      case 'register':
        return RegisterScreen(
          onNavigateToLogin: () => _navigateTo('login'),
          // Bạn có thể thêm onBack cho Register tương tự Login nếu muốn
        );
      case 'welcome':
      default:
        // Khớp với logic AuthIndex.jsx
        return WelcomeScreen(
          onLogin: () => _navigateTo('login'),
          onRegister: () => _navigateTo('register'),
        );
    }
  }
}