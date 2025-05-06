import 'package:flutter/material.dart';

import '../../core/util/number_constants.dart';

class MovieDecorator extends StatelessWidget {
  const MovieDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(NumberConstants.movieDecoratorPadding),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amberAccent,
            width: NumberConstants.movieDecoratorBorderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(NumberConstants.movieDecoratorPadding),
          child: child,
        ),
      ),
    );
  }
}
