import 'package:flutter/foundation.dart';

class TodoListViewModel extends ChangeNotifier{

  final List<String> _tasks = [];
  final List<bool> _isCompleted = [];


  int getItemCount(){
    return _tasks.length;
  }

  void completeTask(int index){
    _isCompleted[index] = !_isCompleted[index];
    notifyListeners();
  }

  bool completedOrNot(int index){
    return _isCompleted[index];
  }

  String getDescriptionTask(int index){
    return _tasks[index];
  }

  onSubmitted(String text){
    if(text.isNotEmpty){
      _tasks.add(text);
      _isCompleted.add(false);
      notifyListeners();
    }
  }
}