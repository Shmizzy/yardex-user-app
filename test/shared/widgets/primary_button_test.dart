import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:yardex_user/shared/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton displays text and responds to tap',
      (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PrimaryButton(
          text: 'Register',
          onPressed: () {
            tapped = true;
          },
        ),
      ),
    ));

    expect(find.text('Register'), findsOneWidget);

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
