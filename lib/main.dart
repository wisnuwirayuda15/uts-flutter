// main.dart

import 'package:flutter/material.dart';
import 'pages/home.dart';
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
      title: 'Putu Wisnu Wirayuda Putra_1202200244_Flutter',
      initialRoute: '/home',
      routes: {
        "/home": (context) => const Home(),
        "/detail": (context) => const Detail(),
        "/checkout": (context) => const Checkout(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
