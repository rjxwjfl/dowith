import 'dart:async';

import 'package:dowith/database/bloc/repository.dart';
import 'package:dowith/database/db_model.dart';

class Bloc{
  final TodoRepository _todoRepository;
  final StreamController<List<DBModel>> _todoController = StreamController<List<DBModel>>.broadcast();

  get todoListStream => _todoController.stream;

  dispose(){
    _todoController.close();
  }

  Bloc(this._todoRepository){
    getTodoList();
  }

  getTodoList() async{
    List<DBModel> todoList = await _todoRepository.getTodoList();
    _todoController.sink.add(todoList);
  }

  addTodo(DBModel todo) async{
    await _todoRepository.createTodo(todo);
    getTodoList();
  }

  deleteTodo(int id) async{
    await _todoRepository.deleteTodo(id);
    getTodoList();
  }

  updateTodo(DBModel todo) async{
    await _todoRepository.updateTodo(todo);
    getTodoList();
  }
}