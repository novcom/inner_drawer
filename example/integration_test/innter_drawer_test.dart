import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// This test is hear to visualize the behavior of the InnerDrawer widget
// as we cannot run integration test on the package.
// The test is not meant to be a real test it's just to aid Widget Test
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const tWidgetSize = Size(720.0, 1280.0);

  group('Demo end-to-end test', () {
    setUp(() {
      WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(
        size: tWidgetSize,
      );
    });
    testWidgets('Should show left child when swiped from left to the middle of screen',
        (tester) async {
      runApp(
        const MaterialApp(
          home: InnerDrawer(
            scaffold: Scaffold(
              body: Text('Home'),
            ),
            leftChild: SizedBox(
              child: Text('Left Child'),
            ),
            rightChild: SizedBox(
              child: Text('Right Child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(
        find.byType(InnerDrawer),
         Offset(tWidgetSize.width / 2, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('Left Child').hitTestable(), findsOneWidget);
      expect(find.text('Right Child'), findsNothing);

      expect(find.text('Home').hitTestable(), findsNothing);
    });
  });
}
