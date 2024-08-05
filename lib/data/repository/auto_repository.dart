
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auto_model.dart';

class AutoRepository {
  final String getAutoUrl = 'https://zs3abkc9h6.execute-api.us-east-1.amazonaws.com/Prod/get_auto';
  final String insertAutoUrl = 'https://zs3abkc9h6.execute-api.us-east-1.amazonaws.com/Prod/insert_auto';
  final String updateAutoUrl = 'https://zs3abkc9h6.execute-api.us-east-1.amazonaws.com/Prod/update_auto';
  final String deleteAutoUrl = 'https://zs3abkc9h6.execute-api.us-east-1.amazonaws.com/Prod/delete_auto_by_id';

  Future<List<AutoModel>> getAutos() async {
    final response = await http.get(Uri.parse(getAutoUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is Map && data.containsKey('autos')) {
        List<dynamic> autosList = data['autos'];
        return autosList.map((item) => AutoModel.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load autos');
    }
  }


  Future<void> createAuto(AutoModel auto) async {
    final response = await http.post(
      Uri.parse(insertAutoUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(auto.toJson()..remove('id')),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create auto');
    }
  }



  Future<void> updateAuto(AutoModel auto) async {
    final response = await http.put(
      Uri.parse(updateAutoUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(auto.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update auto');
    }
  }

  Future<void> deleteAuto(int id) async {
    final response = await http.delete(
      Uri.parse('$deleteAutoUrl'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'id':id})
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete auto');
    }
  }
}
