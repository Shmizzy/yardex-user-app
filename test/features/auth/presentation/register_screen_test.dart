import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yardex_user/features/auth/presentation/register_screen.dart';
import 'package:yardex_user/shared/widgets/primary_button.dart';

void main() {
  testWidgets('Register Screen has a title and form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.text('Register'), findsAtLeastNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Register button triggers validation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
