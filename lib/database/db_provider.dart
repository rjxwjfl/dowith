import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const todoTable = 'database';

class DBProvider {
  static final DBProvider provider = DBProvider();

  static Database? _database;

  // ??= : if '_database' was null, then '_database()' becomes '_database'
  Future<Database> get database async => _database ??= await _dataBase();

  Future<Database> _dataBase() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'todos.db');
    return await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  }

  void initDB(Database db, int version) async {
    await db
        .execute('CREATE TABLE database('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'creator TEXT, '
        'content TEXT, '
        'comment TEXT, '
        'state INTEGER, '
        'startsIn INTEGER, '
        'createAt INTEGER, '
        'expireIn INTEGER, '
        'completedDate INTEGER'
        ')')
        .then((value) {
      print('table created');
    }).catchError((e) {
      print('error when creating DB ${e.toString()}');
    });
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    // ** If you add a column, you must change the version. **
    // if (oldVersion < newVersion){
    //   db.execute("ALTER TABLE database ADD COLUMN recordDate TEXT");
    // }
  }
}
