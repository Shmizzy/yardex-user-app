import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yardex_user/config/router.dart';

void main() {
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    router.go('/login');
    await tester.pumpAndSettle();

    expect(find.text('Login Screen'), findsOneWidget);
  });


}
