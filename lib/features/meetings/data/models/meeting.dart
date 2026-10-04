// Модель Meeting
// AUTO-GENERATED STUB. Реализуйте логику позже.


import '../../../../shared/models/base_model.dart';

class Meeting extends BaseModel {
  const Meeting({
    required this.id,
    required this.title,
    required this.teacherId,
    required this.roomName,
    required this.startAt,
    required this.durationMin,
    required this.status,
    required this.recordingUrl,
  });

  @override
  final String id;
  final String title;
  final String teacherId;
  final String roomName;
  final DateTime startAt;
  final int durationMin;
  final String status;
  final String recordingUrl;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] as String,
      title: json['title']?.toString() ?? '',
      teacherId: json['teacherId']?.toString() ?? '',
      roomName: json['roomName']?.toString() ?? '',
      startAt: DateTime.tryParse(json['startAt']?.toString() ?? '') ?? DateTime.now(),
      durationMin: (json['durationMin'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? '',
      recordingUrl: json['recordingUrl']?.toString() ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'teacherId': teacherId,
    'roomName': roomName,
    'startAt': startAt,
    'durationMin': durationMin,
    'status': status,
    'recordingUrl': recordingUrl,
  };
}
