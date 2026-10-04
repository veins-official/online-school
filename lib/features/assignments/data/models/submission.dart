// Модель Submission
// AUTO-GENERATED STUB. Реализуйте логику позже.


import '../../../../shared/models/base_model.dart';

class Submission extends BaseModel {
  const Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.text,
    required this.grade,
    required this.feedback,
    required this.status,
  });

  @override
  final String id;
  final String assignmentId;
  final String studentId;
  final String text;
  final int grade;
  final String feedback;
  final String status;

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'] as String,
      assignmentId: json['assignmentId']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      grade: (json['grade'] as num?)?.toInt() ?? 0,
      feedback: json['feedback']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'assignmentId': assignmentId,
    'studentId': studentId,
    'text': text,
    'grade': grade,
    'feedback': feedback,
    'status': status,
  };
}
