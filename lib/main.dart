import 'package:custom_render_object/src/progress_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: ProgressBar(
              thumbColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
