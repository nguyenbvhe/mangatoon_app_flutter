import 'package:flutter/material.dart';
import 'login/wrapper.dart';
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
    setState(() {
      _currentView = view;
    });
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
          onBack: () {}, // hoặc bỏ nếu không dùng
          onNavigateToRegister: () => _navigateTo('register'),
        );
    }
  }
}
