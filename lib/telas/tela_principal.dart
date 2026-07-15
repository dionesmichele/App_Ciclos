import 'package:flutter/material.dart';
import 'hoje_tab.dart';
import 'ciclo_tab.dart';
import 'astros_tab.dart';

class MainScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const MainScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _telas = [
    const TodayTab(),
    const CicloTab(),
    const AstrosTab(),
  ];

  final List<String> _titulos = [
    'Hoje',
    'Meu Corpo & Ciclo',
    'Céu & Diário Mágico',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_selectedIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<ThemeMode>(
            initialValue: widget.themeMode,
            icon: const Icon(Icons.palette_outlined),
            onSelected: widget.onThemeChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [Icon(Icons.brightness_auto), SizedBox(width: 8), Text('Sistema')],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [Icon(Icons.light_mode), SizedBox(width: 8), Text('Modo Claro')],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [Icon(Icons.dark_mode), SizedBox(width: 8), Text('Modo Escuro')],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Hoje'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop_outlined), label: 'Ciclo'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Astros'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}