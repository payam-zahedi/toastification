import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return Row(
      children: [
        Image.asset(
          'assets/img/logo-black.png',
          width: 54,
        ),
        const SizedBox(width: 5),
        Text(
          "Toastification",
          style: titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
