import 'package:floor/floor.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:the_magnificent_three/data/datasources/auth_dao.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';

part 'auth_databases.g.dart';

@Database(version: 1, entities: [AuthEntity])
abstract class UserDatabase extends FloorDatabase {
  AuthDao get authdao;
}
