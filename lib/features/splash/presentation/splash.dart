import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/shared/utils/extensions.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkEmail();
  }

  Future<void> _checkEmail() async {
    final SharedPreferences prefs = si<SharedPreferences>();
    final String? email = prefs.getString("userEmail");

    await Future.delayed(const Duration(milliseconds: 600));

    if (email == null || email.isEmpty) {
      if (mounted) context.goNamed(AppRoutes.emailSetup.name);
    } else {
      if (mounted) context.goNamed(AppRoutes.taskList.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.localizations.appName,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
