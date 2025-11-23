import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/config/themes/app_theme.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/l10n/app_localizations.dart';

import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ToDo App',
      theme: AppTheme.theme,
      routerConfig: appRouter,
      locale: Locale('en'),
      supportedLocales: L10n.locales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        );
      },
    );
  }
}
