import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<ToastificationAnimationBuilder?> animationBuilder =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Toastification Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ValueListenableBuilder<ToastificationAnimationBuilder?>(
            valueListenable: animationBuilder,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToastificationButtons(animationBuilder: value),
                  AnimationButtons(
                    onChange: (selectedValue) {
                      animationBuilder.value = selectedValue;
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AnimationButtons extends StatelessWidget {
  const AnimationButtons({
    super.key,
    required this.onChange,
  });

  final ValueChanged<ToastificationAnimationBuilder?> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Animations',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            onChange(
              (context, animation, alignment, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
          child: const Text('Fade'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            onChange(
              (context, animation, alignment, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                );
              },
            );
          },
          child: const Text('Slide'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            onChange(
              (context, animation, alignment, child) {
                return ScaleTransition(scale: animation, child: child);
              },
            );
          },
          child: const Text('Scale'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            onChange(
              (context, animation, alignment, child) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
            );
          },
          child: const Text('Rotate'),
        ),
      ],
    );
  }
}

class ToastificationButtons extends StatelessWidget {
  const ToastificationButtons({
    super.key,
    this.animationBuilder,
  });

  final ToastificationAnimationBuilder? animationBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Default Toasts',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            toastification.show(
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationBuilder: animationBuilder,
              type: ToastificationType.info,
              title: 'Info',
            );
          },
          child: const Text('Info'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            toastification.show(
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationBuilder: animationBuilder,
              type: ToastificationType.warning,
              title: 'Warning',
            );
          },
          child: const Text('Warning'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            toastification.show(
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationBuilder: animationBuilder,
              type: ToastificationType.success,
              title: 'Success',
            );
          },
          child: const Text('Success'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            toastification.show(
              context: context,
              autoCloseDuration: const Duration(seconds: 5),
              animationBuilder: animationBuilder,
              type: ToastificationType.failed,
              title: 'Error',
            );
          },
          child: const Text('Error'),
        ),
      ],
    );
  }
}
