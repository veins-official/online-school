// Репозиторий AssignmentsRepository
// AUTO-GENERATED STUB. Реализуйте логику позже.

import '../../../core/network/pocketbase_client.dart';
import '../models/assignment.dart';

/// Репозиторий доступа к данным AssignmentsRepository.
///
/// Клиент PocketBase инкапсулирован в приватном поле [_pb].
class AssignmentsRepository {
  AssignmentsRepository._internal();

  static final AssignmentsRepository instance = AssignmentsRepository._internal();

  final PocketBaseClient _pb = PocketBaseClient.instance;

  Future<List<Assignment>> fetchAll() async {
    // TODO: заменить на реальный вызов _pb.<collection>.getFullList()
    return const <Assignment>[];
  }

  Future<Assignment?> fetchById(String id) async {
    // TODO: реализовать запрос по id.
    return null;
  }

  Future<Assignment> create(Assignment payload) async {
    // TODO: реализовать создание.
    throw UnimplementedError();
  }

  Future<Assignment> update(Assignment payload) async {
    // TODO: реализовать обновление.
    throw UnimplementedError();
  }

  Future<void> delete(String id) async {
    // TODO: реализовать удаление.
    throw UnimplementedError();
  }
}
