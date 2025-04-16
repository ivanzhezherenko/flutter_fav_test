import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fav_test/application/application.dart';
import 'package:flutter_fav_test/presentation/movie_search_page/movie_search_page.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_app_bar.dart';
import 'package:go_router/go_router.dart';

class MovieListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieAppBar(
      title: 'Movie',
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.search),
          onPressed: () => context.push(MovieSearchPage.path),
        ),
        IconButton(
          icon: switch (Theme.of(context).brightness) {
            Brightness.dark => const Icon(CupertinoIcons.moon, size: 22),
            Brightness.light => const Icon(CupertinoIcons.sun_min, size: 22),
          },
          onPressed: context.changeTheme,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
