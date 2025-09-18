import 'package:floor/floor.dart';

@Entity(tableName: 'patients')
class PatientEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name, detected, pathimage;
  final double confidence;

  PatientEntity(
    this.id, {
    required this.name,
    required this.detected,
    required this.pathimage,
    required this.confidence,
  });
}
