import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yardex_user/config/router.dart';

void main() {
  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    router.go('/home');
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
  });


}
