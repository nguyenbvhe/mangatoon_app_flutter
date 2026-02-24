import 'package:flutter/material.dart';
import 'home/home_page.dart';
import 'login/login_screen.dart';
import 'login/register_screen.dart';
import 'login/auth_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaToon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E79D1),
        ),
      ),
      // Giữ HomePage làm màn hình đầu tiên
      home: const HomePage(),
    );
  }
}