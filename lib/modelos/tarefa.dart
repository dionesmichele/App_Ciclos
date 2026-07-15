import 'package:flutter/material.dart';

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