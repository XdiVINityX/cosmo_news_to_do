import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> tasks = [];
  final List<bool> isCompleted = [];

  void onSubmitted(String text){
    setState(() {
      tasks.add(text);
      isCompleted.add(false);
    });
  }
  void completeTask(int index){
    setState(() {
      isCompleted[index] = !isCompleted[index];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
      ),
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                onSubmitted: (text) {
                  onSubmitted(text);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Добавьте задачу'),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                            onPressed: () => completeTask(index),
                            icon: Icon(
                             isCompleted[index] ? Icons.check_circle : Icons.radio_button_unchecked,
                             color: isCompleted[index] ? Colors.green : null,
                           )
                       ),
                        title: Text(
                            tasks[index],
                      style:  TextStyle(
                      decoration: isCompleted[index] ? TextDecoration.lineThrough : null,
                        ),
                        ),
                      );
                    }),
              ),
            ]),
          ),
        ),
      ),
    );
  }


}
