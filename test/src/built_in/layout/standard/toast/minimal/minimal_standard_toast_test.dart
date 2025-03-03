import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('MinimalStandardToastWidget', () {
    ToastificationTheme buildWithToastificationTheme(
      Widget widget, {
      required ToastificationType type,
      bool showProgressBar = false,
      bool shouldApplyBlurEffect = false,
    }) {
      return ToastificationTheme(
        themeData: ToastificationThemeData(
          flutterTheme: ThemeData.light(),
          direction: TextDirection.ltr,
          showProgressBar: showProgressBar,
          applyBlurEffect: shouldApplyBlurEffect,
          toastStyle: StandardToastStyleFactory.createStyle(
            style: StandardStyle.minimal,
            type: type,
            flutterTheme: ThemeData.light(),
          ),
        ),
        child: widget,
      );
    }

    // Run tests for each ToastificationType variant
    for (ToastificationType type in [
      ToastificationType.info,
      ToastificationType.error,
      ToastificationType.success,
      ToastificationType.warning,
    ]) {
      group('ToastificationType ${type.name}', () {
        testWidgets('should render with default parameters', (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                onCloseTap: () {},
              ),
            ),
          );

          expect(find.byType(MinimalStandardToastWidget), findsOne);
        });

        testWidgets('should render with title and description', (tester) async {
          const kMinimalTitle = 'Test Title';
          const kMinimalDescription = 'Test Description';

          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                title: Text(kMinimalTitle),
                description: Text(kMinimalDescription),
                onCloseTap: () {},
              ),
            ),
          );

          expect(find.text(kMinimalTitle), findsOne);
          expect(find.text(kMinimalDescription), findsOne);
        });

        testWidgets('should render with icon', (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                icon: Icon(Icons.message),
                onCloseTap: () {},
              ),
            ),
          );

          expect(find.byIcon(Icons.message), findsOne);
        });

        testWidgets(
            'should not render LinearProgressIndicator if theme has showProgressBar false',
            (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                progressBarValue: 0.5,
                onCloseTap: () {},
              ),
              showProgressBar: false,
            ),
          );

          expect(find.byType(LinearProgressIndicator), findsNothing);
        });

        testWidgets(
            'should render with LinearProgressIndicator if progressBarValue is provided',
            (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                progressBarValue: 0.5,
                onCloseTap: () {},
              ),
              showProgressBar: true,
            ),
          );

          expect(find.byType(LinearProgressIndicator), findsOne);
        });

        testWidgets('should render with custom progress bar widget',
            (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                progressBarWidget: CircularProgressIndicator(),
                onCloseTap: () {},
              ),
              showProgressBar: true,
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOne);
        });

        testWidgets('should not render blur effect if not enabled in theme',
            (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                progressBarWidget: CircularProgressIndicator(),
                onCloseTap: () {},
              ),
              shouldApplyBlurEffect: false,
            ),
          );

          expect(find.byType(BackdropFilter), findsNothing);
        });

        testWidgets('should render blur effect if enabled in theme',
            (tester) async {
          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                progressBarWidget: CircularProgressIndicator(),
                onCloseTap: () {},
              ),
              shouldApplyBlurEffect: true,
            ),
          );

          expect(find.byType(BackdropFilter), findsOne);
        });

        testWidgets('should trigger onCloseTap callback', (tester) async {
          bool isCloseTapped = false;

          await tester.pumpWidget(
            buildWithToastificationTheme(
              type: type,
              MinimalStandardToastWidget(
                onCloseTap: () {
                  isCloseTapped = true;
                },
              ),
            ),
          );

          await tester.tap(find.byKey(ValueKey('close_button_visible')));

          expect(isCloseTapped, true);
        });
      });
    }
  });
}
