import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/dictionary_model.dart';

class APIservices {
  static String baseurl = "https://api.dictionaryapi.dev/api/v2/entries/en";
  static Future<DictionaryModel?> fetchData(String word) async {
    Uri url = Uri.parse("$baseurl$word");
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DictionaryModel.fromJson(data[0]);
      } else {
        throw Exception("Failure to load meaning");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
