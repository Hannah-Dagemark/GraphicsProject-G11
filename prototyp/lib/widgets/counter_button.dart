import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';

class CounterButton extends StatelessWidget {
  final String? Function() amountGetter;
  final Function() incrementer;
  final Function() decrementer;

  /// Hello :3
  ///
  /// This is a widget that let's you add a neat counter button, with a decrementor, incrementor, and a number in the middle.
  ///
  /// amountGetter function should just return the clean STRING value, there's already exception handling if the value isn't found in the button
  ///
  /// incrementer and decrementer functions should ideally interact with a provider which in some way updates the amountGetter function's return, to make sure the button's digit display updates accordingly :]
  const CounterButton({
    super.key,
    required this.amountGetter,
    required this.incrementer,
    required this.decrementer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppTheme.paddingSmall,
      children: [
        TextButton(
          onPressed: () {
            decrementer();
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: .circular(AppTheme.radiusSmall),
                side: const BorderSide(width: 1, color: Colors.black),
              ),
            ),
          ),
          child: Text("-"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.paddingSmall),
          child: Text(amountGetter() ?? "Couldn't fetch amount"),
        ),
        TextButton(
          onPressed: () {
            incrementer();
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: .circular(AppTheme.radiusSmall),
                side: const BorderSide(width: 1, color: Colors.black),
              ),
            ),
          ),
          child: Text("+"),
        ),
      ],
    );
  }
}
