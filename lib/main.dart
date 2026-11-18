import 'package:flutter/material.dart';
import 'package:refugio/pages/boas_vindas_page.dart';

void main() {
  runApp(const RefugioApp());
}

class RefugioApp extends StatelessWidget {
  const RefugioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refúgio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff145c56),
          primary: const Color(0xff145c56),
        ),
        scaffoldBackgroundColor: const Color(0xfff5f7f2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff5f7f2),
          foregroundColor: Color(0xff183e38),
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff145c56),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const BoasVindasPage(),
    );
  }
}
