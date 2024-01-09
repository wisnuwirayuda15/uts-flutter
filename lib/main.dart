// main.dart

import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/category.dart';
import 'pages/detail.dart';
import 'pages/checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UAS Flutter - Course API',
      initialRoute: '/home',
      routes: {
        "/home": (context) => const Home(),
        "/category": (context) => const Category(),
        "/detail": (context) => const Detail(),
        "/checkout": (context) => const Checkout(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
