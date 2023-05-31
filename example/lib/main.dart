import 'package:example/src/features/home/views/pages/home.dart';
import 'package:example/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const ToastificationApp());
}

class ToastificationApp extends StatelessWidget {
  const ToastificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toastification',
      theme: lightTheme,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1300,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(
            480,
            name: MOBILE,
            scaleFactor: .85,
          ),
          const ResponsiveBreakpoint.autoScale(850, name: TABLET),
          const ResponsiveBreakpoint.autoScaleDown(1250, name: DESKTOP),
        ],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
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
