import 'package:example/src/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HomeHeader()),
            const SliverToBoxAdapter(child: HeaderDescription()),
            SliverPadding(
              padding: const EdgeInsets.only(top: 60),
              sliver: SliverAlignedGrid.extent(
                itemCount: 3,
                maxCrossAxisExtent: 500,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemBuilder: (context, index) => [
                  const FilledToastWidgetsContainer(),
                  const FlatColoredToastWidgetsContainer(),
                  const FlatToastWidgetsContainer(),
                ][index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateAvailableNotification extends StatelessWidget {
  final String message;
  final VoidCallback onUpdatePressed;

  const UpdateAvailableNotification({
    super.key,
    required this.message,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Update Available",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).textTheme.displayMedium?.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onUpdatePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "Not Now",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MinimalNotification extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onClose;
  final MaterialColor color;

  const MinimalNotification({
    super.key,
    required this.iconData,
    required this.title,
    required this.onClose,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = color.withOpacity(0.3);
    Color shadowColor = color.withOpacity(0.1);
    Color iconColor = color == Colors.white
        ? Colors.grey.shade600
        : Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color == Colors.white
                  ? Colors.grey.shade200
                  : color.withOpacity(0.5),
            ),
            child: Icon(
              iconData,
              color: iconColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.grey,
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class TweeterNotification extends StatelessWidget {
  const TweeterNotification({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    required this.time,
  });

  final String title;
  final String? subtitle;
  final String image;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'View',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationComponent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final String time;

  const NotificationComponent({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                if (subtitle != null) const SizedBox(height: 4),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

class FilledToastWidgetsContainer extends StatelessWidget {
  const FilledToastWidgetsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filled Toast Widgets',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.info,
                title: 'Click on Me',
              );
            },
            child: const FilledToastWidget(
              type: ToastificationType.info,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.warning,
                title: 'Click on Me',
              );
            },
            child: const FilledToastWidget(
              type: ToastificationType.warning,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.success,
                title: 'Click on Me',
              );
            },
            child: const FilledToastWidget(
              type: ToastificationType.success,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.failed,
                title: 'Click on Me',
              );
            },
            child: const FilledToastWidget(
              type: ToastificationType.failed,
              title: 'Click on Me',
            ),
          ),
        ],
      ),
    );
  }
}

class FlatToastWidgetsContainer extends StatelessWidget {
  const FlatToastWidgetsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flat Toast Widgets',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.info,
                style: ToastificationStyle.flat,
                title: 'Click on Me',
                description: 'some text',
              );
            },
            child: const FlatToastWidget(
              type: ToastificationType.info,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.warning,
                style: ToastificationStyle.flat,
                title: 'Click on Me',
              );
            },
            child: const FlatToastWidget(
              type: ToastificationType.warning,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.success,
                style: ToastificationStyle.flat,
                title: 'Click on Me',
              );
            },
            child: const FlatToastWidget(
              type: ToastificationType.success,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.failed,
                style: ToastificationStyle.flat,
                title: 'Click on Me',
              );
            },
            child: const FlatToastWidget(
              type: ToastificationType.failed,
              title: 'Click on Me',
            ),
          ),
        ],
      ),
    );
  }
}

class FlatColoredToastWidgetsContainer extends StatelessWidget {
  const FlatColoredToastWidgetsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flat Colored Toast Widgets',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.info,
                style: ToastificationStyle.flatColored,
                title: 'Click on Me',
              );
            },
            child: const FlatColoredToastWidget(
              type: ToastificationType.info,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.warning,
                style: ToastificationStyle.flatColored,
                title: 'Click on Me',
              );
            },
            child: const FlatColoredToastWidget(
              type: ToastificationType.warning,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.success,
                style: ToastificationStyle.flatColored,
                title: 'Click on Me',
              );
            },
            child: const FlatColoredToastWidget(
              type: ToastificationType.success,
              title: 'Click on Me',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                type: ToastificationType.failed,
                style: ToastificationStyle.flatColored,
                title: 'Click on Me',
              );
            },
            child: const FlatColoredToastWidget(
              type: ToastificationType.failed,
              title: 'Click on Me',
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.red,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class HeaderDescription extends StatelessWidget {
  const HeaderDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 900,
        child: Column(
          children: [
            Text(
              'Easy to use Flutter Toasts and Notifications',
              style: theme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Toastification is a Flutter package for displaying customizable toast messages. It provides predefined widgets for success, error, warning, and info messages, as well as a custom widget for flexibility. With Toastification, you can add and manage multiple toast messages at the same time with ease. ',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 2)
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isHorizontal = MediaQuery.of(context).size.width > 700;

    return SizedBox(
      height: isHorizontal ? 300 : null,
      child: Flex(
        direction: isHorizontal ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: math.pi / 32.0,
              child: SizedBox(
                width: 250,
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.secondary,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Flutter',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            'img/toastification_logo_low.png',
            width: 300,
            height: 300,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 34),
            child: Transform.rotate(
              angle: -math.pi / 8.0,
              child: SizedBox(
                width: 250,
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.primary,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Toastification!',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: colors.onPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
