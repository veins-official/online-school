// Репозиторий MeetingsRepository
// AUTO-GENERATED STUB. Реализуйте логику позже.

import '../../../core/network/pocketbase_client.dart';
import '../models/meeting.dart';

/// Репозиторий доступа к данным MeetingsRepository.
///
/// Клиент PocketBase инкапсулирован в приватном поле [_pb].
class MeetingsRepository {
  MeetingsRepository._internal();

  static final MeetingsRepository instance = MeetingsRepository._internal();

  final PocketBaseClient _pb = PocketBaseClient.instance;

  Future<List<Meeting>> fetchAll() async {
    // TODO: заменить на реальный вызов _pb.<collection>.getFullList()
    return const <Meeting>[];
  }

  Future<Meeting?> fetchById(String id) async {
    // TODO: реализовать запрос по id.
    return null;
  }

  Future<Meeting> create(Meeting payload) async {
    // TODO: реализовать создание.
    throw UnimplementedError();
  }

  Future<Meeting> update(Meeting payload) async {
    // TODO: реализовать обновление.
    throw UnimplementedError();
  }

  Future<void> delete(String id) async {
    // TODO: реализовать удаление.
    throw UnimplementedError();
  }
}
