import 'dart:async';

import 'package:dowith/database/db_repository.dart';
import 'package:dowith/database/todo_model.dart';
import 'package:dowith/main.dart';

class Bloc {
  final DBRepository _dbRepository;
  final StreamController<List<TodoModel>> _todoController = StreamController<List<TodoModel>>.broadcast();

  Stream<List<TodoModel>> get todoListStream => _todoController.stream;

  List<TodoModel> _dataList = [];


  Bloc(this._dbRepository){
    getList();
  }


  dispose(){
    _todoController.close();
  }

  Future<void> getList() async{
    List<TodoModel> dataChange = await _dbRepository.getAllData();
    if (dataChange.isNotEmpty){
      _dataList = dataChange;
      _todoController.sink.add(dataChange);
      if (_todoController.stream.isBroadcast){
        _todoController.stream.listen((event) {
          print("${event} listener where?");
        });
      }
      if (todoListStream.isBroadcast){
        print("broadcasting");
      }
    }
  }

  void createData(TodoModel todoModel) async{
    await _dbRepository.createData(todoModel);
    print("previous length : ${_dataList.length}");
    getList();
  }

  void updateData(int id, TodoModel todoModel) async{
    await _dbRepository.updateData(id, todoModel);
    getList();
  }

  void deleteData(int id) async{
    await _dbRepository.deleteData(id);
    getList();
  }

  void deleteAllData() {
    store.box<TodoModel>().removeAll();
    print("remove all");
    getList();
  }
}