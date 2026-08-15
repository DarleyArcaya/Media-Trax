import 'dart:io';
import 'package:client/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:window_manager/window_manager.dart';



Process? _backendProcess;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());

  
    await windowManager.ensureInitialized();
  
  
    await runBackend();

    WindowOptions windowOptions = WindowOptions(
      title: 'MediaTrax'
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {

    });
  }


Future<void> runBackend() async {
  // Carpeta real del .exe compilado (no Directory.current, que cambia en release)
  final exeDir = path.dirname(Platform.resolvedExecutable);

  final backendExecutablePath = path.join(
    exeDir,
    'data', 'flutter_assets', 'assets', 'backend', 'main.exe',
  );

  if (!await File(backendExecutablePath).exists()) {
    debugPrint('Backend no encontrado en: $backendExecutablePath');
    return;
  }

  try {
    _backendProcess = await Process.start(backendExecutablePath, []);

    _backendProcess?.stdout.transform(SystemEncoding().decoder).listen((data) {
      debugPrint('Backend stdout: $data');
    });

    _backendProcess?.stderr.transform(SystemEncoding().decoder).listen((data) {
      debugPrint('Backend stderr: $data');
    });
  } catch (e) {
    debugPrint('Error iniciando backend: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
      ),
    );
  }
}