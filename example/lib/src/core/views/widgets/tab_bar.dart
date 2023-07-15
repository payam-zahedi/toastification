import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

class ToastTypeTabBar extends ConsumerWidget {
  const ToastTypeTabBar({
    super.key,
    this.initialType,
    this.onTypeChanged,
  });
  final ToastificationType? initialType;

  final ValueChanged<ToastificationType>? onTypeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final type = ref.watch(toastDetailControllerProvider).type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4.0),
          child: Text(
            'Choose toast type',
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TabTypeItem(
                selected: type == ToastificationType.success,
                title: 'Success',
                color: successColor,
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeType(ToastificationType.success);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TabTypeItem(
                selected: type == ToastificationType.info,
                title: 'Info',
                color: infoColor,
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeType(ToastificationType.info);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TabTypeItem(
                selected: type == ToastificationType.warning,
                title: 'Warning',
                color: warningColor,
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeType(ToastificationType.warning);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TabTypeItem(
                selected: type == ToastificationType.error,
                title: 'Error',
                color: errorColor,
                onTap: () {
                  ref
                      .read(toastDetailControllerProvider.notifier)
                      .changeType(ToastificationType.error);
                },
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: CustomTabItem(),
            ),
          ],
        )
      ],
    );
  }
}

class TabTypeItem extends StatelessWidget {
  const TabTypeItem({
    super.key,
    required this.selected,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        decoration: BoxDecoration(
          color:
              selected ? color.withOpacity(.1) : theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: selected ? color : theme.colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              height: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorTabItem extends StatelessWidget {
  const IndicatorTabItem({
    super.key,
    this.color,
    required this.text,
  });
  final String text;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Text(text);

    if (color != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: theme.colorScheme.onSurface.withOpacity(.05),
              ),
            ),
          ),
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return child;
  }
}

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 37,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: theme.colorScheme.onSurface.withOpacity(.1),
          width: 1.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'Custom',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              height: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Align(
            alignment: AlignmentDirectional(.4, .1),
            child: SoonWidget(),
          )
        ],
      ),
    );
  }
}
