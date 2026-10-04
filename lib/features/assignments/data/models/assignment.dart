// Модель Assignment
// AUTO-GENERATED STUB. Реализуйте логику позже.


import '../../../../shared/models/base_model.dart';

class Assignment extends BaseModel {
  const Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.studentId,
    required this.subject,
    required this.dueDate,
    required this.status,
  });

  @override
  final String id;
  final String title;
  final String description;
  final String teacherId;
  final String studentId;
  final String subject;
  final DateTime dueDate;
  final String status;

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      teacherId: json['teacherId']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      dueDate: DateTime.tryParse(json['dueDate']?.toString() ?? '') ?? DateTime.now(),
      status: json['status']?.toString() ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'description': description,
    'teacherId': teacherId,
    'studentId': studentId,
    'subject': subject,
    'dueDate': dueDate,
    'status': status,
  };
}
