import 'package:flutter/material.dart';
import '../servicos/database_helper.dart';

class AstrosTab extends StatefulWidget {
  const AstrosTab({super.key});

  @override
  State<AstrosTab> createState() => _AstrosTabState();
}

class _AstrosTabState extends State<AstrosTab> {
  final TextEditingController _pensamentosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDiary();
  }

  // Busca o texto salvo no banco de dados para o dia de hoje
  Future<void> _loadDiary() async {
    final content = await DatabaseHelper.instance.getDiaryToday();
    setState(() {
      _pensamentosController.text = content;
    });
  }

  // Salva o texto automaticamente a cada letra digitada
  void _saveDiary(String value) {
    DatabaseHelper.instance.saveDiary(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            const SizedBox(height: 25),
            Text(
              'Meu Diário Mágico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),
            const Text(
              'Registre suas tiragens de Tarô, humores e reflexões. Seus segredos estão salvos localmente e seguros.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            
            // Campo de texto expandido que salva sozinho!
            Expanded(
              child: TextField(
                controller: _pensamentosController,
                maxLines: null,
                expands: true,
                onChanged: _saveDiary, // Chama a função de salvar no banco a cada tecla!
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Querido diário cósmico...',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16), 
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}