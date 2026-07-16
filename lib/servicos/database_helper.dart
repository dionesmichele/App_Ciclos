/* import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('galaxy_cycle.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Tabela: Tarefas (Aba Hoje)
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        category TEXT NOT NULL DEFAULT 'outro',
        completed INTEGER NOT NULL DEFAULT 0,
        date TEXT NOT NULL
      )
    ''');

    // Tabela: Ciclos e Doses (Aba Ciclo)
    await db.execute('''
      CREATE TABLE cycle_logs (
        id TEXT PRIMARY KEY,
        log_type TEXT NOT NULL,
        date TEXT NOT NULL,
        dosage_mg REAL,
        route TEXT,
        notes TEXT
      )
    ''');

    // Tabela: Sintomas
    await db.execute('''
      CREATE TABLE symptom_logs (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        symptoms TEXT NOT NULL,
        mood TEXT,
        notes TEXT
      )
    ''');

    // Tabela: Diário Mágico (Aba Astros)
    await db.execute('''
      CREATE TABLE diary_entries (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL UNIQUE,
        content TEXT NOT NULL
      )
    ''');
  }

  String get today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  // --- CRUD TAREFAS ---
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return await db.query('tasks', where: 'date = ?', whereArgs: [today]);
  }

  Future<void> insertTask(String title, String category) async {
    final db = await instance.database;
    await db.insert('tasks', {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'category': category,
      'completed': 0,
      'date': today,
    });
  }

  Future<void> updateTaskStatus(String id, int completed) async {
    final db = await instance.database;
    await db.update('tasks', {'completed': completed}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTask(String id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // --- CRUD DIÁRIO ---
  Future<String> getDiaryToday() async {
    final db = await instance.database;
    final result = await db.query('diary_entries', where: 'date = ?', whereArgs: [today]);
    if (result.isNotEmpty) return result.first['content'] as String;
    return '';
  }

  Future<void> saveDiary(String content) async {
    final db = await instance.database;
    await db.insert('diary_entries', {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': today,
      'content': content,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}*/

import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  // Memória temporária para o Chrome não dar tela branca
  final List<Map<String, dynamic>> _tasks = [];
  String _diary = '';

  // Engana o main.dart para ele achar que o banco inicializou
  Future<dynamic> get database async {
    return true; 
  }

  // --- CRUD TAREFAS ---
  Future<List<Map<String, dynamic>>> getTasks() async {
    return _tasks; // Retorna a lista da memória
  }

  Future<void> insertTask(String title, String category) async {
    _tasks.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'category': category,
      'completed': 0,
    });
  }

  Future<void> updateTaskStatus(String id, int completed) async {
    final index = _tasks.indexWhere((t) => t['id'] == id);
    if (index != -1) {
      _tasks[index]['completed'] = completed;
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t['id'] == id);
  }

  // --- CRUD DIÁRIO ---
  Future<String> getDiaryToday() async {
    return _diary;
  }

  Future<void> saveDiary(String content) async {
    _diary = content;
  }
}