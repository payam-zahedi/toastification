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

class Home extends StatelessWidget {
  const Home({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1976d2),
                  minimumSize: const Size(150, 40),
                ),
                onPressed: () {
                  toastification.show(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: 'Title',
                  );
                },
                child: const Text('Default'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(150, 40),
                ),
                onPressed: () {
                  toastification.showInfo(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 5),
                      title: 'Title');
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
                  toastification.showWarning(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: 'Title',
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
                  toastification.showSuccess(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: 'Title',
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
                  toastification.showError(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 5),
                    title: 'Title',
                  );
                },
                child: const Text('Error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
