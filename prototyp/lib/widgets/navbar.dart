import 'package:flutter/material.dart';

class _NavbarButton extends StatelessWidget {
  const _NavbarButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: TextButton(
          child: Padding(
            padding: .all(5),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          onPressed: () => {},
        ),
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _NavbarButton(title: "Hem"),
        _NavbarButton(title: "Handla"),
        _NavbarButton(title: "Kassa"),
      ],
    );
  }
}
