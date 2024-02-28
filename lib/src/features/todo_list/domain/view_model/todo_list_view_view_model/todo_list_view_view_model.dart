import 'package:flutter/foundation.dart';

class TodoListViewViewModel extends ChangeNotifier{

  final List<String> _tasks = [];
  final List<bool> _isCompleted = [];


  int getItemCount() => _tasks.length;

  void completeTask(int index){
    _isCompleted[index] = !_isCompleted[index];
    notifyListeners();
  }

  bool completedOrNot(int index)=> _isCompleted[index];

  String getDescriptionTask(int index)=> _tasks[index];

  void onSubmitted(String text){
    if(text.isNotEmpty){
      _tasks.add(text);
      _isCompleted.add(false);
      notifyListeners();
    }
  }
}
