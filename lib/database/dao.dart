
import 'db_model.dart';
import 'db_provider.dart';

class TodoDao{
  final dbProvider = DBProvider.provider;

  Future<List<DBModel>> getTodoDB() async {
    final db = await dbProvider.database;
    var toDo = await db.query(todoTable, orderBy: 'startsIn');
    List<DBModel> todoList =
    toDo.isNotEmpty ? toDo.map((e) => DBModel.fromDBJson(e)).toList() : [];
    return todoList;
  }

  // Future<List<DBModel>> getFilteredList(DBModel model, String searchType, String input) async{
  //
  //   final db = await dbProvider.database;
  //   var response = await db.query(todoTable, where: searchType, whereArgs: [model.creator]);
  //   return;
  //   // searchType -> "creator = ?" and "title = ?" ...etc
  // }

  Future<void> createDB(DBModel todo) async{
    final db = await dbProvider.database;
    await db.insert(todoTable, todo.toDBJson());
  }

  Future<void> updateDB(DBModel todo) async {
    final db = await dbProvider.database;
    await db.update(todoTable, todo.toDBJson(),
        where: 'id = ?', whereArgs: [todo.id]);

  }

  Future<void> deleteDB(int no) async {
    final db = await dbProvider.database;
    await db.delete('database', where: 'id = ?', whereArgs: [no]);

  }
}
