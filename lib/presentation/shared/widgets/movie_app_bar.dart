import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const MovieAppBar({
    required this.title,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      titleSpacing: 20,
      title: switch (title != null) {
        true => Text(
            title ?? '',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        false => null
      },
      leading: switch (canPop) {
        true => IconButton(
            onPressed: context.pop,
            icon: const Icon(CupertinoIcons.back, size: 38),
          ),
        false => null,
      },
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
