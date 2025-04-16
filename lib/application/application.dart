import 'package:flutter/material.dart';
import 'package:flutter_fav_test/presentation/movie_details_page/movie_details_page.dart';
import 'package:flutter_fav_test/presentation/movie_list_page/movie_list_page.dart';
import 'package:flutter_fav_test/presentation/movie_search_page/movie_search_page.dart';
import 'package:go_router/go_router.dart';

part 'components/router.dart';

part 'components/theme_extension.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111111),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111111),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }

  void toggleTheme([ThemeMode? newMode]) {
    setState(() {
      themeMode = newMode ?? (themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
