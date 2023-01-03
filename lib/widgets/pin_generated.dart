import 'package:flutter/material.dart';
import 'package:log_app_wear/strings.dart';
import 'package:log_app_wear/widgets/button.dart';

class PinGenerated extends StatelessWidget {
  const PinGenerated({super.key, required this.pin, required this.id});

  final String pin;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
            child: Text(
              pin,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          WatchButton(
            onTap: () {
              // BlocProvider.of<HomeBloc>(context).add(RequestPin());
            },
            title: Strings.check,
          ),
        ],
      ),
    );
  }
}
