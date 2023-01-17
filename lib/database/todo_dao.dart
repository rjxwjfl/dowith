import 'package:dowith/database/todo_model.dart';
import 'package:dowith/main.dart';

class TodoDao {
  static final _dbStorage = store.box<TodoModel>();

  Future<List<TodoModel>> getAllData() async {
    List<TodoModel> list = _dbStorage.getAll();
    return list;
  }

  Future<void> createData(TodoModel model) async {
    TodoModel modelData = TodoModel(
      id: model.id,
      title: model.title,
      content: model.content,
      creator: model.creator,
      state: 0,
      createAt: DateTime.now(),
      startsIn: model.startsIn,
      expireIn: model.expireIn,
      completedDate: null,
      comment: null,
    );
    _dbStorage.put(modelData);
  }

  Future<void> updateData(int id, TodoModel model) async {
    TodoModel? modelData = _dbStorage.get(id);
    model = modelData!;
  }

  Future<void> deleteData(int id) async {
    _dbStorage.remove(id);
  }
}
