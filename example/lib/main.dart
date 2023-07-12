import 'package:example/src/features/home/views/pages/home.dart';
import 'package:example/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const ProviderScope(child: ToastificationApp()));
}

class ToastificationApp extends StatelessWidget {
  const ToastificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toastification',
      theme: lightTheme,
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          maxWidth: 1400,
          minWidth: 500,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(
              550,
              name: MOBILE,
              scaleFactor: .9,
            ),
            const ResponsiveBreakpoint.resize(
              850,
              name: TABLET,
              scaleFactor: .85,
            ),
            const ResponsiveBreakpoint.resize(1100, name: DESKTOP),
          ],
          background: Container(
            color: const Color(0xFFF9F9F9),
          ),
        );
      },
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(
          settings,
          (context) {
            return BouncingScrollWrapper.builder(
              context,
              buildPage(settings.name ?? ''),
            );
          },
        );
      },
    );
  }

  Widget buildPage(String route) {
    return switch (route) {
      HomeScreen.route => const HomeScreen(),
      _ => const SizedBox.shrink(),
    };
  }
}

class Routes {
  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
