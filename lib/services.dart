import 'package:http/http.dart' as http;
import 'package:myapp/dictonary_model.dart';

class APIservices {
  String baseurl = "https://api.dictionaryapi.dev/api/v2/entries/en";
  Future<DictonaryModel> fetchData(String word) async {
    Uri url = Uri.parse("$baseurl$word");
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
      }
      ;
    } catch (e) {
      print(e.toString());
    }
  }
}
