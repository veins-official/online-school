import 'package:pocketbase/pocketbase.dart';

class PocketBaseClient {
  PocketBaseClient._();
  static final PocketBaseClient instance = PocketBaseClient._();

  late final PocketBase _client = PocketBase(Env.pocketBaseUrl);

  PocketBase get client => _client;

  RecordService get users => _client.collection('users');
  RecordService get assignments => _client.collection('assignments');
  RecordService get submissions => _client.collection('submissions');
  RecordService get meetings => _client.collection('meetings');
  RecordService get teacherStudent => _client.collection('teacher_student');
  RecordService get notifications => _client.collection('notifications');

  bool get isAuthenticated => _client.authStore.isValid;
  String? get currentUserId => _client.authStore.record?.id;

  String? get currentUserRole =>
      _client.authStore.record?.get<String>('role');
}

