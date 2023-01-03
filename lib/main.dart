import 'package:flutter/material.dart';
import 'package:log_app_wear/loading.dart';
import 'package:log_app_wear/strings.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black
      ),
      home: WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
          return AmbientMode(
            builder: (context, mode, child) {
              if (mode == WearMode.active) {
                return const Scaffold(
                  body: PageLoading(),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    ),
  );
}
