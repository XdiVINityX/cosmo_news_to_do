import 'package:cosmo_news_to_do/src/features/todo_list/presentation/view_model/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
      ),
      body:   SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(children: [
              const SizedBox(height: 10),
              _TextFieldInput(textEditingController: TextEditingController()),
              const SizedBox(height: 10),
              const Expanded(child: _ListViewTask()),
            ]),
          ),
        ),
      ),
    );
}

class _TextFieldInput extends StatelessWidget {

  const _TextFieldInput({
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    const colorTurquoise = Color(0xFF188077);
    final viewModel = context.read<TodoListViewModel>();
    return  TextField(
      controller: textEditingController,
      cursorColor:colorTurquoise,
      onSubmitted: (text) {
        viewModel.onSubmitted(text);
        textEditingController.clear();
      },
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTurquoise)),
          labelText: 'Добавьте задачу',
      labelStyle: TextStyle(color: colorTurquoise)),
    );
  }
}

class _ListViewTask extends StatefulWidget {
  const _ListViewTask();

  @override
  State<_ListViewTask> createState() => _ListViewTaskState();
}

class _ListViewTaskState extends State<_ListViewTask> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoListViewModel>();
    return ListView.builder(
        itemCount: viewModel.getItemCount(),
        itemBuilder: (context, index) =>
            Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: const Color(0xFFEAEAEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              leading: _LeadingIconButton(index: index),
              title: _TextTitle(index: index),
            ),
          )
    );
  }
}

class _LeadingIconButton extends StatelessWidget {

  const _LeadingIconButton({
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodoListViewModel>();
    return IconButton(
        onPressed: () => viewModel.completeTask(index),
        icon: Icon(
          viewModel.completedOrNot(index) ? Icons.check_circle : Icons.radio_button_unchecked,
          color: viewModel.completedOrNot(index)? Colors.green : null,
        )
    );
  }
}

class _TextTitle extends StatelessWidget {
  const _TextTitle({required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodoListViewModel>();
    return Text(
      viewModel.getDescriptionTask(index),
      style: TextStyle(
        decoration: viewModel.completedOrNot(index) ? TextDecoration.lineThrough : null,
      ),
    );
  }
}





