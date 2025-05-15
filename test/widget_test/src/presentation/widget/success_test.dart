import 'package:dojo_challenges/src/presentation/widget/movie_card.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data/mock_data.dart';

void main() {
  testWidgets('Success() should display the success', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(
      MaterialApp(home: Success(movies: [movieMock], callback: () {})),
    );

    //Then
    expect(
      find.descendant(
        of: find.byType(MovieScaffold),
        matching: find.byType(GridView),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(GridView),
        matching: find.byType(GridTile),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(GridTile),
        matching: find.byType(MovieCard),
      ),
      findsOneWidget,
    );
  });
}
