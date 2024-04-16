import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
  });

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
      bottom: const PreferredSize(
        preferredSize: Size(double.infinity, 1),
        child: Divider(height: 0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 57);
}
