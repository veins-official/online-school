// Экран видеозвонка (LiveKit)
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Экран видеозвонка (LiveKit)
class VideoCallScreen extends ConsumerWidget {
  const VideoCallScreen({super.key, required this.meetingId});

  final String meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: реализовать UI, используя meetingId.
    return Scaffold(
      body: Center(child: Text('VideoCallScreen: ${meetingId}')),
    );
  }
}
