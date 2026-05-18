import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback func;

  const NavigationButton({
    super.key,
    required this.text,
    required this.func
    });
    
  @override
  Widget build(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return TextButton(
  onPressed: func,

  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return cs.primary; // hover background
      }
      return Colors.white; // normal background
    }),

    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.white; // hover text
      }
      return cs.primary; // normal text
    }),

    side: WidgetStateProperty.resolveWith((states) {
      return BorderSide(width: 2, color: cs.primary);
    }),
  ),

  child: Padding(padding: EdgeInsets.all(8), child: Text(text, style: TextStyle(fontSize: 20)),
));
  }
}