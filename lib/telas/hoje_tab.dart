import 'package:flutter/material.dart';
import '../modelos/tarefa.dart';

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