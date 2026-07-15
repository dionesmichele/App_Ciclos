import 'package:flutter/material.dart';

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