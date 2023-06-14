import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/WorldStatesModel.dart';
import 'Utilities/api_url.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  //for countries

  Future<List<dynamic>> fetchcountriesListRecord() async {
    var data;

    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
     data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
