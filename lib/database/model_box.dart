import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../objectbox.g.dart';
import 'todo_model.dart';

class ModelBox{
  late final Store store;
  late final Admin _admin;
  late final Box<TodoModel> _storage;

  ModelBox._create(this.store){
    if(Admin.isAvailable()){
      _admin = Admin(store);
    }
    _storage = Box<TodoModel>(store);

    if(_storage.isEmpty()){
      print("is empty");
    }
  }

  static Future<ModelBox> create() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseDirectory = p.join(documentsDirectory.path, "obx-demo-relations");

    final store = await openStore(directory: databaseDirectory);
    return ModelBox._create(store);
  }

  Stream<List<TodoModel>> databaseStream(){
    final queryBuilder = _storage.query().order(TodoModel_.startsIn);
    return queryBuilder.watch(triggerImmediately: true).map((query) => query.find());
  }

  void saveTodo(TodoModel todoModel) {
    // if (text.isEmpty) {
    //   // Do not allow an empty task text.
    //   // A real app might want to display an UI hint about that.
    //   return;
    // }
    // if (task == null) {
    //   // Add a new task (task id is 0).
    //   task = Task(text);
    // } else {
    //   // Update an existing task (task id is > 0).
    //   task.text = text;
    // }
    // Set or update the target of the to-one relation to Tag.
    // task.tag.target = tag;
    // taskBox.put(task);
    // debugPrint('Saved task ${task.text} with tag ${task.tag.target!.name}');
    _storage.put(todoModel);
  }
}