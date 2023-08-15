import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/widgets/image.dart';
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return Row(
      children: [
        const Image(
          image: logoImage,
          width: 54,
        ),
        const SizedBox(width: 12),
        if (!context.isInMobileZone)
          Text(
            "Toastification",
            style: titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
      ],
    );
  }
}
