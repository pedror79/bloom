import 'package:flutter_test/flutter_test.dart';

import 'package:bloom_app/app/app.dart';

void main() {
  testWidgets('Bloom app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const BloomApp());

    expect(find.byType(BloomApp), findsOneWidget);
  });
}