import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mine/encryption_key.dart';
import 'package:mine/models/mine.dart';

class DataStorage {
  static final DataStorage instance = DataStorage._internal();

  factory DataStorage() {
    return instance;
  }
  DataStorage._internal() {}
  static final Key key = Key.fromBase64(
    encryptionKey,
  );
  static final Encrypter encrypter = Encypter(AES(key));
  static final IV iv = IV.fromLength(16);

  File todoStorage = File("");

  Future _loadTodoFile() async {
    todoStorage = File(
      "${(await getApplicationDocumentsDirectory()).path}/todos.json",
    );
  }

  Future<void> saveTodos(List<ToDo> todos) async {
    //list for all todos to save them
    List<String> encryptedTodos = List.generate(
      todos.length,
      (index) => jsonEncode(todos[index].toEncryptJson(encrypter, iv)),
    );
    //wrtitn to the file
  }
}
