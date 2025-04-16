part of '../application.dart';

extension ThemeExtension on BuildContext {
  void changeTheme([ThemeMode? mode]) {
    findAncestorStateOfType<ApplicationState>()?.toggleTheme(mode);
  }
}
