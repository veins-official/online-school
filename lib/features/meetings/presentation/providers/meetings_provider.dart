// Riverpod-провайдеры для meetings
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/meetings_repository.dart';
import '../../data/models/meeting.dart';

/// Провайдер репозитория.
final meetingsRepositoryProvider = Provider<MeetingsRepository>(
  (ref) => MeetingsRepository.instance,
);

/// Провайдер списка.
final meetingsListProvider =
    FutureProvider.autoDispose<List<Meeting>>((ref) async {
  return ref.watch(meetingsRepositoryProvider).fetchAll();
});

/// Провайдер одного элемента по id.
final meetingsByIdProvider =
    FutureProvider.autoDispose.family<Meeting?, String>((ref, id) async {
  return ref.watch(meetingsRepositoryProvider).fetchById(id);
});
