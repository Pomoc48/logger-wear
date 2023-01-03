import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  const PageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.signal_wifi_statusbar_connected_no_internet_4,
        size: 48,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
