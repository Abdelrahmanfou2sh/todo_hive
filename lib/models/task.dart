import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.isCompleted,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  DateTime time;
  @HiveField(5)
  bool isCompleted;

  factory Task.create({
    required String? title,
    required String? description,
    DateTime? date,
    DateTime? time,
  }) => Task(
    id: Uuid().v1(),
    title: title ?? '',
    description: description ?? '',
    date: date ?? DateTime.now(),
    time: time ?? DateTime.now(),
    isCompleted: false,
  );
}
