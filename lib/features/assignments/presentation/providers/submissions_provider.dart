// Riverpod-провайдеры для submissions
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/submissions_repository.dart';
import '../../data/models/submission.dart';

/// Провайдер репозитория.
final submissionsRepositoryProvider = Provider<SubmissionsRepository>(
  (ref) => SubmissionsRepository.instance,
);

/// Провайдер списка.
final submissionsListProvider =
    FutureProvider.autoDispose<List<Submission>>((ref) async {
  return ref.watch(submissionsRepositoryProvider).fetchAll();
});

/// Провайдер одного элемента по id.
final submissionsByIdProvider =
    FutureProvider.autoDispose.family<Submission?, String>((ref, id) async {
  return ref.watch(submissionsRepositoryProvider).fetchById(id);
});
