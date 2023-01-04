import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:log_app_wear/functions.dart';
import 'package:log_app_wear/models/list.dart';

String backend = "https://loggerapp.lukawski.xyz/";

Future<Map> getToken() async {
  String? refreshToken = GetStorage().read("refreshToken");
  if (refreshToken == null) {
    return {"success": false};
  }

  Response response = await post(
    Uri.parse("${backend}refresh/"),
    headers: {"Rtoken": refreshToken},
  );

  return loginResult(response: response);
}

Future<Map> createConnection() async {
  Response response = await put(Uri.parse("${backend}connect/"));
  Map map = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return {
      "success": true,
      "id": map["id"],
      "pin": map["pin"],
    };
  }

  return {"success": false, "message": map["message"]};
}

Future<Map> getLists({required String token}) async {
  Response response = await makeRequest(
    url: "${backend}lists/",
    headers: {"Token": token},
    type: RequestType.get,
  );

  if (response.statusCode == 403) {
    return await getLists(token: await renewToken());
  }

  dynamic decoded = jsonDecode(utf8.decode(response.bodyBytes));
  if (decoded == null) return {"data": [], "token": token};

  List<ListOfItems> lists = [];
  for (Map element in decoded) {
    lists.add(ListOfItems.fromMap(element));
  }

  return {"data": lists, "token": token};
}

Future<Map> loginResult({
  required Response response,
  bool save = false,
}) async {
  Map map = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    if (save) await GetStorage().write("refreshToken", map["refresh_token"]);
    return {"success": true, "token": map["token"]};
  }

  return {"success": false, "message": map["message"]};
}

Future<void> forgetSavedToken() async {
  await GetStorage().remove("refreshToken");
}

Future<Map> addItem({
  required int listId,
  required int timestamp,
  required String token,
}) async {
  return await makeRequest(
    url: "${backend}items/?timestamp=$timestamp&list_id=$listId",
    headers: {"Token": token},
    type: RequestType.post,
  );
}
