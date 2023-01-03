import 'package:flutter/material.dart';

class WatchButton extends StatelessWidget {
  const WatchButton({super.key, required this.onTap, required this.title});

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        height: 56,
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer
              .withOpacity(0.75),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
