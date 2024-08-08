import 'package:hive_flutter/hive_flutter.dart';

 class ToDoDataBase {
  List todoList = [];

  // reference the box
  final _myBox = Hive.box("myBox");

// run first time ever opening app
  void createInitialData() {
    todoList = [
      ['Make tutorials', false],
      ['Do chores', false],
      ['Read Bible', false]
    ];
  }

  // load the data from database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put('TODOLIST', todoList);
  }
}
