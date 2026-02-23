import 'package:flutter/material.dart';
import 'login/auth_wrapper.dart';    
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
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E79D1),
          primary: const Color(0xFF8E79D1),
        ),
        // Bạn có thể thêm scaffoldBackgroundColor nếu muốn
        // scaffoldBackgroundColor: Colors.transparent,
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
  /// 'login' | 'register'
  String _currentView = 'login';

  void _navigateTo(String view) {
    setState(() => _currentView = view);
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: _buildCurrentBody(),
    );
  }

  Widget _buildCurrentBody() {
    switch (_currentView) {
      case 'register':
        return RegisterScreen(
          onNavigateToLogin: () => _navigateTo('login'),
        );

      case 'login':
      default:
        return LoginScreen(
          // Nếu LoginScreen không thực sự dùng onBack → có thể bỏ tham số này
          onBack: () {}, 
          onNavigateToRegister: () => _navigateTo('register'),
        );
    }
  }
}