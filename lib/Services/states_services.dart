import 'dart:convert';

import 'package:covidapp/Model/world_states_model.dart';
import 'package:covidapp/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class StateServices {

  Future<WorldStatesModal> fetchWorldStatesRecords ()async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode==200){
      var  data = jsonDecode(response.body);
      return WorldStatesModal.fromJson(data);
      
    }else{
      throw Exception('error');
    }
  }


   Future<List<dynamic>> countriesListApi ()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode==200){
      var  data = jsonDecode(response.body);
      return data;
      
    }else{
      throw Exception('error');
    }
  }


}