import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:yardex_user/shared/widgets/auth_text_field.dart';

void main() {
  testWidgets('AuthTextField displays label, hint, and validates',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            child: Column(
              children: [
                AuthTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: TextEditingController(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Trigger form validation
                    Form.of(tester.element(find.byType(AuthTextField))).validate();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);


    await tester.enterText(find.byType(AuthTextField), '');
    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Please enter your email'), findsOneWidget);
  });
}
