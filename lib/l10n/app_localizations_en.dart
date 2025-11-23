// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ToDo App';

  @override
  String get loading => 'Loading...';

  @override
  String get noTasks => 'No tasks yet.';

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get yourTasks => 'Your Tasks';

  @override
  String get owner => 'Owner';

  @override
  String get doYouReallyWantToLogout => 'Do you really want to logout?';

  @override
  String get logout => 'Logout';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskTitle => 'Title';

  @override
  String get taskDescription => 'Description';

  @override
  String get enterTaskTitle => 'Enter title';

  @override
  String get enterTaskDescription => 'Enter description';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get share => 'Share';

  @override
  String get shareTask => 'Share Task';

  @override
  String get delete => 'Delete';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get areYouSureYouWantToDeleteThisTask =>
      'Are you sure you want to delete this task?';

  @override
  String get shareTaskHint => 'Enter email to share';

  @override
  String get setupEmail => 'Setup Email';

  @override
  String get enterEmailToContinue => 'Enter your email to continue';

  @override
  String get email => 'Email';

  @override
  String get submit => 'Submit';

  @override
  String get enterAValidEmail => 'Enter a valid email';

  @override
  String sharedWithCount(int count) {
    return 'Shared with $count';
  }
}
