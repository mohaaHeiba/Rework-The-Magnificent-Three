import 'package:floor/floor.dart';

@Entity(tableName: 'signup')
class AuthEntity {
  @primaryKey
  final int? id;
  final String name, email;
  final int phone;
  AuthEntity(
    this.id, {
    required this.name,
    required this.email,
    required this.phone,
  });
}
