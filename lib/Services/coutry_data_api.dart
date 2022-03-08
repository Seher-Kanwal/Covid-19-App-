import 'dart:convert';

import 'package:covid_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class CountryData{
  //we don't need to store all data, so we don't create model for that
  //simply create a list of dynamic type

  Future<List<dynamic>> getCountryData() async{
    final response = await  http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200)
      {
        var data= jsonDecode(response.body);
        return data;
      }
    else
      {
        throw Exception('Error').toString();
      }
  }
}