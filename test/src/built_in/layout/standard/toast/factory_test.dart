import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('StandardToastWidgetFactory', () {
    group('Unit Tests', () {
      test(
          'returns DefaultStandardToastWidget for StandardStyle.flat, flatColored, fillColored',
          () {
        // A helper function to reduce repeated logic
        Widget createWidget(StandardStyle style) {
          return StandardToastWidgetFactory.createStandardToastWidget(
            style: style,
            title: const Text('Title'),
            description: const Text('Description'),
            icon: const Icon(Icons.info),
            onCloseTap: () {},
          );
        }

        final flatWidget = createWidget(StandardStyle.flat);
        final flatColoredWidget = createWidget(StandardStyle.flatColored);
        final fillColoredWidget = createWidget(StandardStyle.fillColored);

        // Verify each is DefaultStandardToastWidget
        expect(flatWidget, isA<DefaultStandardToastWidget>());
        expect(flatColoredWidget, isA<DefaultStandardToastWidget>());
        expect(fillColoredWidget, isA<DefaultStandardToastWidget>());
      });

      test('returns MinimalStandardToastWidget for StandardStyle.minimal', () {
        final widget = StandardToastWidgetFactory.createStandardToastWidget(
          style: StandardStyle.minimal,
          title: const Text('Title'),
          description: const Text('Description'),
          icon: const Icon(Icons.info),
          onCloseTap: () {},
        );

        expect(widget, isA<MinimalStandardToastWidget>());
      });

      test('returns SimpleStandardToastWidget for StandardStyle.simple', () {
        final widget = StandardToastWidgetFactory.createStandardToastWidget(
          style: StandardStyle.simple,
          title: const Text('Title'),
          onCloseTap: () {},
        );

        expect(widget, isA<SimpleStandardToastWidget>());
      });

      test('passes correct parameters to DefaultStandardToastWidget', () {
        final widget = StandardToastWidgetFactory.createStandardToastWidget(
          style: StandardStyle.flat, // Produces DefaultStandardToastWidget
          title: const Text('My Title'),
          description: const Text('My Description'),
          icon: const Icon(Icons.warning),
          onCloseTap: () {},
          showCloseButton: false,
          closeButton: const ToastCloseButton(
            showType: CloseButtonShowType.onHover,
          ),
          progressBarWidget: const LinearProgressIndicator(),
        );

        expect(widget, isA<DefaultStandardToastWidget>());

        // Cast to DefaultStandardToastWidget to check fields
        final defaultWidget = widget as DefaultStandardToastWidget;
        expect(defaultWidget.title, isA<Text>());
        expect((defaultWidget.title! as Text).data, 'My Title');

        expect(defaultWidget.description, isA<Text>());
        expect((defaultWidget.description! as Text).data, 'My Description');

        expect(defaultWidget.icon, isA<Icon>());
        expect(defaultWidget.showCloseButton, false);

        // We can’t directly test the callback logic with a pure unit test,
        // but we can confirm it’s not null
        expect(defaultWidget.onCloseTap, isNotNull);

        expect(defaultWidget.closeButton, isA<ToastCloseButton>());
        expect(defaultWidget.closeButton.showType,
            equals(CloseButtonShowType.onHover));
        expect(defaultWidget.progressBarWidget, isA<LinearProgressIndicator>());
      });

      test('passes correct parameters to MinimalStandardToastWidget', () {
        final widget = StandardToastWidgetFactory.createStandardToastWidget(
          style: StandardStyle.minimal, // Produces MinimalStandardToastWidget
          title: const Text('My Title'),
          description: const Text('My Description'),
          icon: const Icon(Icons.warning),
          onCloseTap: () {},
          showCloseButton: false,
          closeButton: const ToastCloseButton(
            showType: CloseButtonShowType.onHover,
          ),
          progressBarWidget: const LinearProgressIndicator(),
        );

        expect(widget, isA<MinimalStandardToastWidget>());

        // Cast to MinimalStandardToastWidget to check fields
        final minimalWidget = widget as MinimalStandardToastWidget;
        expect(minimalWidget.title, isA<Text>());
        expect((minimalWidget.title! as Text).data, 'My Title');

        expect(minimalWidget.description, isA<Text>());
        expect((minimalWidget.description! as Text).data, 'My Description');

        expect(minimalWidget.icon, isA<Icon>());
        expect(minimalWidget.showCloseButton, false);

        // We can’t directly test the callback logic with a pure unit test,
        // but we can confirm it’s not null
        expect(minimalWidget.onCloseTap, isNotNull);

        expect(minimalWidget.closeButton, isA<ToastCloseButton>());
        expect(minimalWidget.closeButton.showType,
            equals(CloseButtonShowType.onHover));
        expect(minimalWidget.progressBarWidget, isA<LinearProgressIndicator>());
      });

      test('respects default values when optional params are omitted', () {
        final widget = StandardToastWidgetFactory.createStandardToastWidget(
          style: StandardStyle.simple,
          title: const Text('Title'),
          onCloseTap: () {},
        );

        // simple => SimpleStandardToastWidget
        final simpleWidget = widget as SimpleStandardToastWidget;

        // By default: showCloseButton = true
        expect(simpleWidget.showCloseButton, isTrue);

        // default closeButton is ToastCloseButton()
        expect(simpleWidget.closeButton, isA<ToastCloseButton>());

        // minimal or no description => in Simple widget, that’s normal
        expect(simpleWidget.title, isA<Text>());
      });
    });
  });
}
