import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/presentation/email_setup.dart';
import 'package:todo_app/features/splash/presentation/splash.dart';
import 'package:todo_app/features/tasks/presentation/views/task_list.dart';

enum AppRoutes { splash, emailSetup, taskList }

final rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.splash.name,
      builder: (context, state) => const Splash(),
    ),
    GoRoute(
      path: '/${AppRoutes.emailSetup.name}',
      name: AppRoutes.emailSetup.name,
      builder: (_, _) => const EmailSetup(),
    ),
    GoRoute(
      path: '/${AppRoutes.taskList.name}',
      name: AppRoutes.taskList.name,
      builder: (_, _) => const TaskList(),
    ),
  ],
);
