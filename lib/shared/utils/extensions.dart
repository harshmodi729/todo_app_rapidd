import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppLocalizations get localizations => AppLocalizations.of(this)!;

  void showSnackBar(String message, {bool? isSuccess}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess == null
            ? null
            : isSuccess
            ? Colors.green
            : Colors.red,
        behavior: .floating,
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      ),
    );
  }
}

extension WidgetExtension on Widget {
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: .symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget paddingAll(double padding) {
    return Padding(padding: .all(padding), child: this);
  }

  Widget paddingHorizontal(double padding) {
    return Padding(
      padding: .symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget paddingVertical(double padding) {
    return Padding(
      padding: .symmetric(vertical: padding),
      child: this,
    );
  }

  Widget paddingOnly({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) {
    return Padding(
      padding: .only(top: top, right: right, bottom: bottom, left: left),
      child: this,
    );
  }
}

extension StringExtension on String {
  bool validateEmail() {
    return RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$").hasMatch(this);
  }
}

extension NumberExtension on num {
  Widget spaceWidth() {
    return SizedBox(width: toDouble());
  }

  Widget spaceHeight() {
    return SizedBox(height: toDouble());
  }
}
