import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_portal/presentation/widgets/app_logo.dart';

class NewsListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsListAppBar({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppLogo(),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(LucideIcons.search)),
        IconButton(onPressed: () {}, icon: const Icon(LucideIcons.menu)),
      ],
    );
  }
}
