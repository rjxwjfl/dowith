
import 'package:dowith/database/database_model.dart';
import 'package:dowith/main.dart';

import '../objectbox.g.dart';

class DatabaseProvider {

  final _storage = store.box<DatabaseModel>();

  DatabaseProvider._();

  void _getAllDatabase(){
    _storage.getAll();
  }

  void createDatabase(){
     _storage.put(DatabaseModel(state: state, createAt: createAt, startsIn: startsIn, expireIn: expireIn));
  }

  void deleteDatabase(int id){
    _storage.remove(id);
  }

  void updateDatabase(int id){
    _storage.get(id).
  }
}