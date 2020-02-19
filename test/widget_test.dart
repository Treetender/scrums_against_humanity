// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:scrums_against_humanity/main.dart';

void main() {

  testWidgets('Initial App Setup Test', (WidgetTester tester)async {
    
    await tester.pumpWidget(SettingsProvider());

    expect(find.byType(SettingsProvider), findsOneWidget);
    expect(find.byType(App), findsOneWidget);
  });
}
