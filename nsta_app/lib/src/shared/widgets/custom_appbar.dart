import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      actions: actions,
    );
  }
}

// import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final IconData icon;

  const CustomAppBar2({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.backgroundColor, this.onPressed, required this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: onPressed, icon: Icon(icon, color: Colors.white,)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      actions: actions,
    );
  }
}

class CustomAppBar3 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBar3({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      // centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      actions: actions,
    );
  }
}
