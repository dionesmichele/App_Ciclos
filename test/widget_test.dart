import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App de Rotina',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainScreen(),
    );
  }
}

// --- TELA PRINCIPAL (NAVEGAÇÃO) ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Atualizamos a lista para incluir a nossa nova tela de Astros!
  final List<Widget> _telas = [
    const TodayTab(),
    const Center(child: Text('Tela de Ciclo/Hormonização em construção 🩸', style: TextStyle(fontSize: 18))),
    const AstrosTab(), // <--- Nova tela conectada aqui!
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Hoje'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop_outlined), label: 'Ciclo'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Astros'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// --- TELA 3: ASTROS E TARÔ (NOVIDADE!) ---
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
      appBar: AppBar(
        title: const Text('Céu & Diário Mágico'),
        backgroundColor: Colors.deepPurple[800], // Cor mais escura e mística
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView permite que a tela role para baixo se o conteúdo for longo
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SEÇÃO MACRO: O CÉU DE HOJE (Mock Data)
            const Text(
              'O Céu de Hoje',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.dark_mode, color: Colors.indigo),
                        SizedBox(width: 10),
                        Text('Lua: Minguante em Câncer', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Alerta: Mercúrio em quadratura com Saturno. Comunicação pode ficar truncada.',
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. SEÇÃO DOS SIGNOS (Peixes e Capricórnio)
            Card(
              color: Colors.deepPurple[50],
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('♓ Peixes (Sol)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('A intuição está altíssima hoje. Confie nos seus instintos para tomar decisões acadêmicas ou no trabalho.'),
                    Divider(height: 20),
                    Text('♑ Capricórnio (Ascendente/Lua)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('A necessidade de organizar a rotina vai bater forte. Aproveite a energia para estruturar seus projetos sem se cobrar demais.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 3. SEÇÃO MICRO: DIÁRIO DE TARÔ E PENSAMENTOS
            const Text(
              'Meu Diário Místico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            
            // Campo de Tarô
            TextField(
              controller: _tarotController,
              maxLines: 3, // Caixa de texto maior
              decoration: const InputDecoration(
                labelText: 'Cartas do Tarô de Hoje...',
                hintText: 'Ex: Tirei A Sacerdotisa. Significa que...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.style),
              ),
            ),
            const SizedBox(height: 15),

            // Campo de Reflexões
            TextField(
              controller: _pensamentosController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Reflexões e Humores...',
                hintText: 'Como os trânsitos de hoje estão me afetando?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.psychology),
              ),
            ),
            const SizedBox(height: 20),

            // Botão de Salvar
            SizedBox(
              width: double.infinity, // Ocupa a largura toda
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Aqui no futuro vamos fazer o código para salvar o texto!
                  _tarotController.clear();
                  _pensamentosController.clear();
                },
                child: const Text('Salvar Registro do Dia', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- NOSSA TELA HOJE (COMPLETA) ---
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
      appBar: AppBar(
        title: const Text('Hoje'),
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarJanelaNovaTarefa,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
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