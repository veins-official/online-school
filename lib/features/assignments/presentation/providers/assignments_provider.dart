// Riverpod-провайдеры для assignments
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/assignments_repository.dart';
import '../../data/models/assignment.dart';

/// Провайдер репозитория.
final assignmentsRepositoryProvider = Provider<AssignmentsRepository>(
  (ref) => AssignmentsRepository.instance,
);

/// Провайдер списка.
final assignmentsListProvider =
    FutureProvider.autoDispose<List<Assignment>>((ref) async {
  return ref.watch(assignmentsRepositoryProvider).fetchAll();
});

/// Провайдер одного элемента по id.
final assignmentsByIdProvider =
    FutureProvider.autoDispose.family<Assignment?, String>((ref, id) async {
  return ref.watch(assignmentsRepositoryProvider).fetchById(id);
});
