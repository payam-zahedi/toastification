import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastTypeTabBar extends StatefulWidget {
  const ToastTypeTabBar({
    super.key,
    this.initialType,
    this.onTypeChanged,
  });
  final ToastificationType? initialType;

  final ValueChanged<ToastificationType?>? onTypeChanged;

  @override
  State<ToastTypeTabBar> createState() => _ToastTypeTabBarState();
}

class _ToastTypeTabBarState extends State<ToastTypeTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline, width: 1.3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (value) {
              if (widget.onTypeChanged != null) {
                final type = switch (value) {
                  1 => ToastificationType.success,
                  2 => ToastificationType.info,
                  3 => ToastificationType.warning,
                  4 => ToastificationType.error,
                  _ => null,
                };

                widget.onTypeChanged!(type);
              }
            },
            padding: const EdgeInsets.all(4),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: theme.colorScheme.onSurface.withOpacity(.1),
              ),
            ),
            labelPadding: const EdgeInsets.all(4),
            dividerColor: Colors.transparent,
            labelColor: theme.colorScheme.onPrimary,
            unselectedLabelColor: theme.colorScheme.onSurface,
            labelStyle: theme.textTheme.titleSmall?.copyWith(
              height: 1,
              fontWeight: FontWeight.w500,
            ),
            enableFeedback: true,
            splashFactory: InkRipple.splashFactory,
            splashBorderRadius: BorderRadius.circular(8.0),
            tabs: const [
              Tab(
                child: ToastTabItem(
                  text: 'Default',
                ),
              ),
              Tab(
                child: ToastTabItem(
                  text: 'Success',
                  color: Color(0xff84FF89),
                ),
              ),
              Tab(
                child: ToastTabItem(
                  text: 'Info',
                  color: Color(0xff84C4FF),
                ),
              ),
              Tab(
                child: ToastTabItem(
                  text: 'Warning',
                  color: Color(0xffFFCE84),
                ),
              ),
              Tab(
                child: ToastTabItem(
                  text: 'Error',
                  color: Color(0xffFF8484),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ToastTabItem extends StatelessWidget {
  const ToastTabItem({
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
              borderRadius: BorderRadius.circular(8.0),
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
