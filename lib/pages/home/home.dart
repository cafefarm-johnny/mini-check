import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 할 일')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 10,
          children: [
            Text('할 일 예제1'),
            Text('할 일 예제2'),
            Text('할 일 예제3'),
            Text('할 일 예제4'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
