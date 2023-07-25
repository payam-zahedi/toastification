import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavigationView extends ConsumerWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidePaddings = context.responsiveValue(
      desktop: 58.0,
      tablet: 32.0,
    );
    final theme = Theme.of(context);
    final size = context.responsiveValue(
      desktop: const Size.square(56),
      tablet: const Size.square(56),
      mobile: const Size.square(48),
    );

    final edgeInsets = context.responsiveValue(
      desktop: const EdgeInsets.symmetric(horizontal: 32),
      tablet: const EdgeInsets.symmetric(horizontal: 16),
    );

    final filledButton = context.responsiveValue(
      desktop: FilledButton.icon(
        style: FilledButton.styleFrom(
          padding: edgeInsets,
          minimumSize: size,
          backgroundColor: theme.colorScheme.onSurfaceVariant,
          foregroundColor: theme.colorScheme.onSurface,
        ),
        onPressed: () {},
        label: const Text('Save My Toast'),
        icon: const Icon(Iconsax.save_add_copy),
      ),
      tablet: FilledButton(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: size,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
        ),
        onPressed: () {},
        child: const Icon(Iconsax.save_add_copy, size: 20),
      ),
    );

    final filledButton2 = context.responsiveValue(
      desktop: FilledButton.icon(
        style: FilledButton.styleFrom(
          padding: edgeInsets,
          minimumSize: size,
        ),
        onPressed: () {
          copyCode(context, ref.read(toastDetailControllerProvider));
        },
        label: const Text('Copy Code'),
        icon: const Icon(Iconsax.document_copy_copy),
      ),
      tablet: FilledButton(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: size,
        ),
        onPressed: () {
          copyCode(context, ref.read(toastDetailControllerProvider));
        },
        child: const Icon(Iconsax.document_copy_copy, size: 20),
      ),
    );
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: sidePaddings),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border(
          top: BorderSide(width: 1, color: theme.colorScheme.onSurfaceVariant),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(.05),
            blurRadius: 92,
            offset: const Offset(0, -52),
            spreadRadius: -24,
          )
        ],
      ),
      child: Row(
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
              padding: edgeInsets,
              minimumSize: size,
              backgroundColor: theme.colorScheme.onSurfaceVariant,
              foregroundColor: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              final toastDetail = ref.read(toastDetailControllerProvider);

              showCurrentToast(context, toastDetail);
            },
            child: const Text('Preview on My Screen'),
          ),
          const Spacer(),
          filledButton,
          const SizedBox(width: 16, height: 16),
          filledButton2,
        ],
      ),
    );
  }
}
