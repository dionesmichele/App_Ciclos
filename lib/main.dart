import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Transformamos o MyApp em StatefulWidget para ele conseguir gerenciar a mudança de tema
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variável que controla o tema atual do app inteiro
  ThemeMode _themeMode = ThemeMode.system;

  // Função que será chamada pelas telas de baixo para atualizar o tema
  void _alterarTema(ThemeMode modo) {
    setState(() {
      _themeMode = modo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App de Rotina',
      themeMode: _themeMode, // Vincula a variável ao controle do aplicativo

      // --- MODO CLARO (Lilás, ciano e tons suaves) ---
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

      // --- MODO ESCURO (Espaço profundo, neon e galáxia) ---
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          primary: const Color(0xFFCE93D8),
          secondary: Colors.cyanAccent,
          tertiary: const Color(0xFFF06292),
          surface: const Color(0xFF0B001A), // Fundo ultra escuro cósmico
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      
      // Passamos o estado atual e a função de mudança para a tela de navegação
      home: MainScreen(themeMode: _themeMode, onThemeChanged: _alterarTema),
    );
  }
}

// --- TELA PRINCIPAL (GERENCIA A NAVEGAÇÃO E O TOPO GLOBAL) ---
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

  // Títulos automáticos baseados na aba selecionada
  final List<String> _titulos = [
    'Hoje',
    'Meu Corpo & Ciclo',
    'Céu & Diário Mágico',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Criamos um AppBar global único para evitar duplicações de layout
      appBar: AppBar(
        title: Text(_titulos[_selectedIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          // Menu flutuante para escolha manual do tema
          PopupMenuButton<ThemeMode>(
            initialValue: widget.themeMode,
            icon: const Icon(Icons.palette_outlined), // Ícone de paleta de cores no topo direito
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


// --- TELA 1: HOJE ---
class TodayTab extends StatefulWidget {
  const TodayTab({super.key});

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  final List<Task> tasks = [
    Task(title: 'Varrer a casa', category: 'Limpeza', icon: Icons.cleaning_services),
    Task(title: 'Entregar resenha', category: 'Faculdade', icon: Icons.book),
    Task(title: 'Fazer exercício', category: 'Saúde', icon: Icons.fitness_center),
    Task(title: 'Beber água', category: 'Hidratação', icon: Icons.local_drink),
    Task(title: 'Fazer comida', category: 'Alimentação', icon: Icons.kitchen),
  ];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  void _mostrarJanelaNovaTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'O que você precisa fazer?'),
              ),
              TextField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria (ex: Casa, Estudos)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _tituloController.clear();
                _categoriaController.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_tituloController.text.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(
                      title: _tituloController.text,
                      category: _categoriaController.text.isNotEmpty ? _categoriaController.text : 'Geral',
                      icon: Icons.task_alt,
                    ));
                  });
                  _tituloController.clear();
                  _categoriaController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Icon(task.icon),
            title: Text(task.title),
            subtitle: Text(task.category),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                setState(() {
                  task.isCompleted = value ?? false;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarJanelaNovaTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- TELA 2: CICLO & HORMONIZAÇÃO ---
class CicloTab extends StatefulWidget {
  const CicloTab({super.key});

  @override
  State<CicloTab> createState() => _CicloTabState();
}

class _CicloTabState extends State<CicloTab> {
  bool _isHormonizando = false;

  @override
  Widget build(BuildContext context) {
    final corPrincipal = _isHormonizando ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: SwitchListTile(
                title: const Text('Modo Hormonização', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Altera o monitoramento para controle de doses'),
                value: _isHormonizando,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (bool value) {
                  setState(() {
                    _isHormonizando = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 250, // Círculo um pouquinho maior para dar espaço
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: corPrincipal, width: 6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- O SEU GIF DO YIN YANG ENTRA AQUI! ---
                    ClipOval(
                      child: Image.network(
                        'https://i.gifer.com/M8Q9.gif', // Link direto do arquivo
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8), // Um pequeno espaço
                    
                    Text(_isHormonizando ? 'Dia 12' : 'Dia 14', style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    Text(_isHormonizando ? 'da hormonização' : 'do ciclo', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: corPrincipal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _isHormonizando ? 'Próxima dose amanhã' : 'Fase Lútea',
                        style: TextStyle(color: corPrincipal, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(_isHormonizando ? Icons.vaccines : Icons.water_drop),
              label: Text(_isHormonizando ? 'Registrar Dose Hoje' : 'Registrar Início da Menstruação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: corPrincipal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- TELA 3: ASTROS E DIÁRIO ---
class AstrosTab extends StatefulWidget {
  const AstrosTab({super.key});

  @override
  State<AstrosTab> createState() => _AstrosTabState();
}

class _AstrosTabState extends State<AstrosTab> {
  final TextEditingController _tarotController = TextEditingController();
  final TextEditingController _pensamentosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O Céu de Hoje',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 10),
                        const Text('Lua: Minguante em Câncer', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        SizedBox(width: 10),
                        Expanded(child: Text('Alerta: Mercúrio em quadratura com Saturno.')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('♓ Peixes (Sol)', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('A intuição está altíssima hoje. Confie nos seus instintos.'),
                    Divider(height: 20),
                    Text('♑ Capricórnio (Ascendente/Lua)', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Aproveite a energia para organizar a sua rotina sem se cobrar demais.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Meu Diário Mágico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tarotController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Cartas do Tarô...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.style),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _pensamentosController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Reflexões e Humores...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.psychology),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  _tarotController.clear();
                  _pensamentosController.clear();
                },
                child: const Text('Salvar Registro do Dia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final String category;
  final IconData icon;
  bool isCompleted;

  Task({
    required this.title,
    required this.category,
    required this.icon,
    this.isCompleted = false,
  });
}