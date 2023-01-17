import 'package:dowith/database/todo_dao.dart';
import 'package:dowith/database/todo_model.dart';

class DBRepository{
  final TodoDao _todoDao;

  DBRepository(this._todoDao);
  Future<List<TodoModel>> getAllData() => _todoDao.getAllData();
  Future<void> createData(TodoModel todoModel) => _todoDao.createData(todoModel);
  Future<void> updateData(int id, TodoModel todoModel) => _todoDao.updateData(id, todoModel);
  Future<void> deleteData(int id) => _todoDao.deleteData(id);
}
