import 'dart:convert';
import 'package:covid_app/Models/world_statics_modal.dart';
import 'package:covid_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class WorldStatics {
  Future < WorldStaticsModel> getworldStatics() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStaticsModel.fromJson(data);
    } else {
      throw Exception('Error').toString();
    }
  }

}

