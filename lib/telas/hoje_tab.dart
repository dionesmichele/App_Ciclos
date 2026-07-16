import 'package:flutter/material.dart';
import '../servicos/database_helper.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({super.key});

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask() async {
    if (_tituloController.text.trim().isEmpty) return;
    
    final categoria = _categoriaController.text.isNotEmpty ? _categoriaController.text : 'Geral';
    await DatabaseHelper.instance.insertTask(_tituloController.text, categoria);
    
    _tituloController.clear();
    _categoriaController.clear();
    _loadTasks(); // Recarrega a lista do banco de dados
  }

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
                _addTask();
                Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _tasks.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma tarefa para hoje.\nRelaxe e aproveite!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  final isCompleted = task['completed'] == 1;
                  
                  return Dismissible(
                    key: Key(task['id']),
                    background: Container(
                      color: Colors.redAccent,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await DatabaseHelper.instance.deleteTask(task['id']);
                      _loadTasks();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tarefa excluída!')),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: CheckboxListTile(
                        activeColor: Theme.of(context).colorScheme.primary,
                        title: Text(
                          task['title'],
                          style: TextStyle(
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                            color: isCompleted ? Colors.grey : null,
                          ),
                        ),
                        subtitle: Text(task['category']),
                        value: isCompleted,
                        onChanged: (val) async {
                          await DatabaseHelper.instance.updateTaskStatus(task['id'], val! ? 1 : 0);
                          _loadTasks();
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarJanelaNovaTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}