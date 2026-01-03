import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_check/app/app.dart';

void main() {
  testWidgets('renders the home screen via the app router', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Home'), findsNWidgets(2));
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
