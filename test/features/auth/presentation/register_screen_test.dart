import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yardex_user/config/router.dart';
import 'package:yardex_user/features/auth/presentation/register_screen.dart';
import 'package:yardex_user/shared/widgets/auth_text_field.dart';
import 'package:yardex_user/shared/widgets/primary_button.dart';

void main() {
  testWidgets('Register Screen has a title and form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.text('Register'), findsAtLeastNWidgets(2));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
  });

  testWidgets('Register button triggers validation',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: SafeArea(child: RegisterScreen())));

    await tester.tap(find.byType(PrimaryButton).first);
    await tester.pump();

    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
  });

  testWidgets('Cancel button navigates back to Onboarding Screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    router.go('/register');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('Shows loading indicator during registration',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    await tester.enterText(find.byType(AuthTextField).at(0), 'username');
    await tester.enterText(find.byType(AuthTextField).at(1), 'email@gmail.com');
    await tester.enterText(find.byType(AuthTextField).at(2), 'Password12');
    await tester.enterText(find.byType(AuthTextField).at(3), 'Password12');
    await tester.enterText(find.byType(AuthTextField).at(4), '1234567890');

    await tester.tap(find.byType(PrimaryButton).first);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.runAsync(() async {
      Future.delayed(const Duration(seconds: 3));
    });
    await tester.pumpAndSettle();

    
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
