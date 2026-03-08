// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hardware_info_kit_example/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify Hardware Info Demo loads', (WidgetTester tester) async {
    // Mock the platform channel
    const channel = MethodChannel('hardware_info_kit');
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'getSystemInfo') {
          return {
            'cpu': {
              'name': 'Test CPU',
              'cores': 8,
              'frequency': 3.5,
            },
            'memory': {
              'total': 16000000000,
              'available': 8000000000,
              'used': 8000000000,
            },
            'os': {
              'name': 'Test OS',
              'version': '1.0',
              'architecture': 'x64',
            },
          };
        }
        return null;
      },
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    // Wait for the first frame
    await tester.pump();
    
    // Wait for the async operation to complete
    await tester.pump(const Duration(seconds: 1));

    // Verify that the app title is present
    expect(find.text('Hardware Info Kit'), findsOneWidget);
  });
}
