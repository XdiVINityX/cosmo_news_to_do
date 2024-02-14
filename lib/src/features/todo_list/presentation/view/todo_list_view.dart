import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
      ),
      body: const Center(
        child: Text('Здесь будет список дел'),
      ),
    );
  }
}