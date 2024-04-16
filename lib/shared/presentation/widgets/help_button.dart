import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      onPressed: onPressed,
    );
  }
}
