// Отправка решения
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Отправка решения
class SubmissionScreen extends ConsumerWidget {
  const SubmissionScreen({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: реализовать UI, используя assignmentId.
    return Scaffold(
      body: Center(child: Text('SubmissionScreen: ${assignmentId}')),
    );
  }
}
