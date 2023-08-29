import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/main.dart'; // Replace with your app's main.dart import

void main() {
  testWidgets('Tic Tac Toe game test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TicTacToeApp());

    // Verify that the initial player is X.
    expect(find.text('Current Player: X'), findsOneWidget);

    // Make some moves and verify the updated player and board.
    await tester.tap(find.byKey(Key('cell00'))); // Player X makes a move
    await tester.pump();
    expect(find.text('Current Player: O'), findsOneWidget);
    expect(find.text('X'), findsOneWidget); // Verify the X mark on the board

    await tester.tap(find.byKey(Key('cell11'))); // Player O makes a move
    await tester.pump();
    expect(find.text('Current Player: X'), findsOneWidget);
    expect(find.text('O'), findsOneWidget); // Verify the O mark on the board

    // TODO: Add more test scenarios as needed

    // Reset the game and verify that the board is cleared.
    await tester.tap(find.text('Play Again'));
    await tester.pump();
    expect(find.text('Current Player: X'), findsOneWidget);
    expect(find.text(''), findsNWidgets(9)); // Verify all cells are empty
  });
}
