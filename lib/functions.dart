import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:log_app_wear/home/bloc/functions.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';
import 'package:log_app_wear/models/list.dart';

enum RequestType { post, get, delete }

Future<dynamic> makeRequest({
  required String url,
  required Map<String, String> headers,
  required RequestType type,
}) async {
  Response response;

  switch (type) {
    case RequestType.post:
      response = await post(Uri.parse(url), headers: headers);
      break;
    case RequestType.get:
      return await get(Uri.parse(url), headers: headers);
    case RequestType.delete:
      response = await delete(Uri.parse(url), headers: headers);
      break;
  }

  Map map = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return {
      "success": true,
      "message": map["message"],
      "token": headers["Token"],
    };
  }

  if (response.statusCode == 403) {
    return await makeRequest(
      url: url,
      headers: {"Token": await renewToken()},
      type: type,
    );
  }

  return {
    "success": false,
    "message": map["message"],
    "token": headers["Token"],
  };
}

String subtitleCount(int count) {
  return count == 1 ? "$count time" : "$count times";
}

Future<String> renewToken() async {
  Map response = await getToken();
  return response["token"];
}

int dateToTimestamp(DateTime date, [TimeOfDay? time]) {
  if (time != null) {
    DateTime d = date.add(Duration(hours: time.hour, minutes: time.minute));
    return d.millisecondsSinceEpoch ~/ 1000;
  }
  return date.millisecondsSinceEpoch ~/ 1000;
}
