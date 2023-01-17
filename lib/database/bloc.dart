import 'dart:async';

import 'package:dowith/database/db_repository.dart';
import 'package:dowith/database/todo_model.dart';

class Bloc {
  final DBRepository _dbRepository;
  final StreamController<List<TodoModel>> _todoController = StreamController<List<TodoModel>>.broadcast();
  get todoListStream => _todoController.stream;
  static List<TodoModel> _dataList = [];

  dispose(){
    _todoController.close();
  }

  Bloc(this._dbRepository){
    getList();
  }

  getList() async{
    _dataList = await _dbRepository.getAllData();
    _todoController.sink.add(_dataList);
  }

  createData(TodoModel todoModel) async{
    await _dbRepository.createData(todoModel);
  }

  updateData(int id, TodoModel todoModel) async{
    await _dbRepository.updateData(id, todoModel);
    getList();
  }

  deleteData(int id) async{
    await _dbRepository.deleteData(id);
    getList();
  }
}