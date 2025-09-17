import 'package:floor/floor.dart';

@Entity(tableName: 'auth')
class AuthEntity {
  @primaryKey
  final int? id;
  final String name, email, pass;
  AuthEntity(
    this.id, {
    required this.name,
    required this.email,
    required this.pass,
  });
}
