import 'package:dowith/database/dao.dart';
import 'package:dowith/database/db_model.dart';

class TodoRepository{
  final DataAccessObject _todoDao;

  TodoRepository(this._todoDao);
  Future<List<DBModel>> getTodoList() => _todoDao.getTodoDB();
  Future<void> createTodo(DBModel todo) => _todoDao.createDB(todo);
  Future<void> updateTodo(DBModel todo) => _todoDao.updateDB(todo);
  Future<void> deleteTodo(int id) => _todoDao.deleteDB(id);
}