import 'package:flutter/material.dart';
import 'package:resepku/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue, // Warna utama aplikasi
          onPrimary: Colors.white, // Warna teks pada elemen utama
      ),
    ),
    home: HomePage(),
    );
  }
}



