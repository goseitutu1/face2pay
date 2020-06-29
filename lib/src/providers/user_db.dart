import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/username.dart';
import '../models/user_contact.dart';

class UserDbProvider {

  var readyCompleter = Completer();
  Future get ready => readyCompleter.future;
  Database db;

  UserDbProvider(){
    init().then((_) {
      // mark the provider ready when init completes
      readyCompleter.complete();
    });
    // insert();
  }

  Future init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = join(appDocDir.path, "user.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version){
        newDb.execute("""
        CREATE TABLE User
        (
          id INTEGER PRIMARY KEY,
          username TEXT DEFAULT ,
          contact TEXT DEFAULT
        )
        """);
      }
    );
  }

  // Map<String, dynamic> values = {
  //   'id': 0,
  //   'username': 'Username',
  //   'contact': 'Contact',
  // };

  // Future<int> insert() async{
  //   await ready;
  //   final result = await db.insert(
  //     'User', 
  //     values, 
  //     );
  //   return result;
  // }

  Future<UserNameModel> fetchUserName(int id) async {
     // Make sure it is ready before fetching...
    await ready;
    final map = await db.query(
      'User',
      columns:['username'],
      where: "id = ?",
      whereArgs: [id],
    );

    if(map.length > 0){
      return UserNameModel.db(map.first);
    }

    return null;
  }

  Future<int> updateUserName(UserNameModel username, int id) async {
    await ready;
    final result = await db.update(
      'User', 
      username.toMapForDb(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<UserContactModel> fetchUserContact(int id) async {
     // Make sure it is ready before fetching...
    await ready;
    final map = await db.query(
      'User',
      columns: ['contact'],
      where: "id = ?",
      whereArgs: [id],
    );

    if(map.length > 0){
      return UserContactModel.db(map.first);
    }

    return null;
  }

  Future<int> updateUserContact(UserContactModel contact, int id) async {
    await ready;
    final result = await db.update(
      'User', 
      contact.toMapForDb(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future close() => db.close();
}

final userDbProvider = UserDbProvider();