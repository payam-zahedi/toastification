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
        title: const Text('Toastification Example'),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1976d2),
                  ),
                  onPressed: () {
                    Toastification().addNotification(
                      context: context,
                      builder: (context, holder) {
                        return ToastWidget(
                          item: holder,
                          title: 'Title',
                        );
                      },
                      autoCloseDuration: const Duration(seconds: 10),
                    );
                  },
                  child: const Text('Default'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Toastification().addNotification(
                      context: context,
                      builder: (context, holder) {
                        return InfoToastWidget(
                          item: holder,
                          title: 'Title',
                        );
                      },
                    );
                  },
                  child: const Text('Info'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  onPressed: () {
                    Toastification().addNotification(
                      context: context,
                      builder: (context, holder) {
                        return WarningToastWidget(
                          item: holder,
                          title: 'Title',
                        );
                      },
                      autoCloseDuration: const Duration(seconds: 10),
                    );
                  },
                  child: const Text('Warning'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Toastification().addNotification(
                      context: context,
                      builder: (context, holder) {
                        return SuccessToastWidget(
                          item: holder,
                          title: 'Title',
                        );
                      },
                      autoCloseDuration: const Duration(seconds: 10),
                    );
                  },
                  child: const Text('Success'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Toastification().addNotification(
                      context: context,
                      builder: (context, holder) {
                        return ErrorToastWidget(
                          item: holder,
                          title: 'Title',
                        );
                      },
                      autoCloseDuration: const Duration(seconds: 10),
                    );
                  },
                  child: const Text('Error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
