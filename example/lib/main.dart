import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/pages/home.dart';
import 'package:example/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

final themeVariantProvider = StateProvider<bool>((ref) {
  return false;
});

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: ToastificationApp()));
}

class ToastificationApp extends ConsumerWidget {
  const ToastificationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInterFont = ref.watch(themeVariantProvider);

    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Toastification',
        theme: useInterFont ? lightInterTheme : lightJakartaTheme,
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            child,
            maxWidth: 1350,
            minWidth: 300,
            defaultScale: false,
            breakpoints: [
              /// Mobile: 320 - 549
              const ResponsiveBreakpoint.resize(
                320,
                name: smallMobileBreakpointTag,
                scaleFactor: .9,
              ),
              const ResponsiveBreakpoint.resize(
                420,
                name: mobileBreakpointTag,
                scaleFactor: .9,
              ),

              /// Tablet: 550 - 849
              const ResponsiveBreakpoint.resize(
                550,
                name: tabletBreakpointTag,
                scaleFactor: .9,
              ),

              /// Desktop: 850 - 1099
              const ResponsiveBreakpoint.resize(
                850,
                name: desktopBreakpointTag,
                scaleFactor: .85,
              ),

              /// ultra: 1100 - 1400
              const ResponsiveBreakpoint.resize(
                1100,
                name: ultraBreakpointTag,
              ),
            ],
            background: Container(
              color: Theme.of(context).colorScheme.surface,
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
      ),
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
