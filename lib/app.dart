// Корневой виджет приложения
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class OnlineSchoolApp extends StatelessWidget {
  const OnlineSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Online School',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter.instance.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
