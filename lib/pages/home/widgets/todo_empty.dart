import 'package:flutter/material.dart';

class TodoEmpty extends StatelessWidget {
  const TodoEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            '오늘의 할 일이 아직 없어요. 🙂',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '해야 할 일이 생기면'),
                TextSpan(
                  text: '\n+ 버튼',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '을 눌러 추가해보세요.'),
              ],
            ),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
