import 'package:flutter/material.dart';
import 'telas/tela_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _alterarTema(ThemeMode modo) {
    setState(() {
      _themeMode = modo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App de Rotina',
      themeMode: _themeMode,

      // --- MODO CLARO ---
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C27B0),
          primary: const Color(0xFF9C27B0),
          secondary: const Color(0xFF00BCD4),
          tertiary: const Color(0xFFF48FB1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      // --- MODO ESCURO ---
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          primary: const Color(0xFFCE93D8),
          secondary: Colors.cyanAccent,
          tertiary: const Color(0xFFF06292),
          surface: const Color(0xFF0B001A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      
      home: MainScreen(themeMode: _themeMode, onThemeChanged: _alterarTema),
    );
  }
}