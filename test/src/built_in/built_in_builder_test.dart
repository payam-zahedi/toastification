import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('BuiltInToastBuilder - themeMode', () {
    Future<Brightness> pumpToastBrightness(
      WidgetTester tester, {
      required ThemeData appTheme,
      ToastificationConfig? config,
    }) async {
      final toast = BuiltInToastBuilder(
        type: ToastificationType.info,
        style: ToastificationStyle.flat,
        direction: TextDirection.ltr,
        title: const Text('title'),
        onCloseTap: () {},
        showProgressBar: false,
        closeButton: const ToastCloseButton(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: appTheme,
          home: Material(
            child: config == null
                ? toast
                : ToastificationConfigProvider(config: config, child: toast),
          ),
        ),
      );
      // MaterialApp animates a theme change.
      await tester.pumpAndSettle();

      final context = tester.element(find.text('title'));
      return ToastificationTheme.of(context).toastStyle!.brightness;
    }

    testWidgets('stays light in a dark app by default', (tester) async {
      final brightness = await pumpToastBrightness(
        tester,
        appTheme: ThemeData.dark(),
      );

      expect(brightness, Brightness.light);
    });

    testWidgets('light ignores a dark app', (tester) async {
      final brightness = await pumpToastBrightness(
        tester,
        appTheme: ThemeData.dark(),
        config: const ToastificationConfig(
          themeMode: ToastificationThemeMode.light,
        ),
      );

      expect(brightness, Brightness.light);
    });

    testWidgets('dark ignores a light app', (tester) async {
      final brightness = await pumpToastBrightness(
        tester,
        appTheme: ThemeData.light(),
        config: const ToastificationConfig(
          themeMode: ToastificationThemeMode.dark,
        ),
      );

      expect(brightness, Brightness.dark);
    });

    testWidgets('followAppTheme follows the app brightness', (tester) async {
      const config = ToastificationConfig(
        themeMode: ToastificationThemeMode.followAppTheme,
      );

      expect(
        await pumpToastBrightness(
          tester,
          appTheme: ThemeData.dark(),
          config: config,
        ),
        Brightness.dark,
      );
      expect(
        await pumpToastBrightness(
          tester,
          appTheme: ThemeData.light(),
          config: config,
        ),
        Brightness.light,
      );
    });
  });
}
