// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';

class PinGenerated extends StatelessWidget {
  const PinGenerated({super.key, required this.pin, required this.id});

  final String pin;
  final int id;

  @override
  Widget build(BuildContext context) {
    runRefresh(context, id);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            pin,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  void runRefresh(BuildContext context, int id) async {
    Response response = await get(
      Uri.parse("https://loggerapp.lukawski.xyz/connect/?id=$id"),
    );

    Map map = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      await GetStorage().write("refreshToken", map["refresh_token"]);
      BlocProvider.of<HomeBloc>(context).add(AutoLogin());

    } else {
      runRefresh(context, id);
    }
  }
}