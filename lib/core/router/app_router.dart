// Конфигурация go_router с guard-ами
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/assignments/presentation/screens/assignments_list_screen.dart';
import '../../features/assignments/presentation/screens/assignment_detail_screen.dart';
import '../../features/assignments/presentation/screens/create_assignment_screen.dart';
import '../../features/meetings/presentation/screens/meetings_list_screen.dart';
import '../../features/meetings/presentation/screens/video_call_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/recordings/presentation/screens/recordings_list_screen.dart';
import '../../features/schedule/presentation/screens/schedule_screen.dart';
import '../../features/students/presentation/screens/students_list_screen.dart';
import '../../features/students/presentation/screens/assign_teacher_screen.dart';

import 'routes.dart';

/// Singleton-обёртка над GoRouter.
///
/// Реализация скрыта за приватным полем [_router], доступ — через [router].
class AppRouter {
  AppRouter._();

  static final AppRouter instance = AppRouter._();

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.login,
    routes: <RouteBase>[
      GoRoute(path: Routes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: Routes.register, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: Routes.home, builder: (_, __) => const ProfileScreen()),
      GoRoute(path: Routes.profile, builder: (_, __) => const ProfileScreen()),
      GoRoute(path: Routes.students, builder: (_, __) => const StudentsListScreen()),
      GoRoute(path: '/students/assign', builder: (_, __) => const AssignTeacherScreen()),
      GoRoute(path: Routes.assignments, builder: (_, __) => const AssignmentsListScreen()),
      GoRoute(path: '/assignments/create', builder: (_, __) => const CreateAssignmentScreen()),
      GoRoute(
        path: Routes.assignmentDetail,
        builder: (_, state) => AssignmentDetailScreen(
          assignmentId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(path: Routes.meetings, builder: (_, __) => const MeetingsListScreen()),
      GoRoute(
        path: Routes.videoCall,
        builder: (_, state) => VideoCallScreen(
          meetingId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(path: Routes.recordings, builder: (_, __) => const RecordingsListScreen()),
      GoRoute(path: Routes.schedule, builder: (_, __) => const ScheduleScreen()),
    ],
    // TODO: добавить redirect на основе auth-состояния и роли.
    redirect: (BuildContext context, GoRouterState state) => null,
  );

  GoRouter get router => _router;
}
