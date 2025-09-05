import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our Hive box
  final _myBox = Hive.box('myBox');

  // run this method if this is the 1st time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
