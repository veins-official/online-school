// Репозиторий SubmissionsRepository
// AUTO-GENERATED STUB. Реализуйте логику позже.

import '../../../core/network/pocketbase_client.dart';
import '../models/submission.dart';

/// Репозиторий доступа к данным SubmissionsRepository.
///
/// Клиент PocketBase инкапсулирован в приватном поле [_pb].
class SubmissionsRepository {
  SubmissionsRepository._internal();

  static final SubmissionsRepository instance = SubmissionsRepository._internal();

  final PocketBaseClient _pb = PocketBaseClient.instance;

  Future<List<Submission>> fetchAll() async {
    // TODO: заменить на реальный вызов _pb.<collection>.getFullList()
    return const <Submission>[];
  }

  Future<Submission?> fetchById(String id) async {
    // TODO: реализовать запрос по id.
    return null;
  }

  Future<Submission> create(Submission payload) async {
    // TODO: реализовать создание.
    throw UnimplementedError();
  }

  Future<Submission> update(Submission payload) async {
    // TODO: реализовать обновление.
    throw UnimplementedError();
  }

  Future<void> delete(String id) async {
    // TODO: реализовать удаление.
    throw UnimplementedError();
  }
}
