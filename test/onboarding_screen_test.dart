import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yardex_user/config/router.dart';

void main() {
  
  testWidgets('Onboarding screen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    expect(find.text('Welcome to the App!'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Continue as Guest'), findsOneWidget);
  });

  testWidgets('Onboarding screen navigates to login screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    router.go('/');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Login Screen'), findsOneWidget);
  });

  testWidgets('Onboarding screen navigates to home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    router.go('/');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue as Guest'));
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
  });
}
