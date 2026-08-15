import 'package:flutter/material.dart';
import 'package:mediatrax/pages/main_page.dart';

void main() {
  runApp(const MainFile());
}

class MainFile extends StatefulWidget {
  const MainFile({super.key});

  @override
  State<MainFile> createState() => _MainFileState();
}

class _MainFileState extends State<MainFile> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
      )
    );
  }
}