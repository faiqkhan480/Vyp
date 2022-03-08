import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vyv/utils/constants.dart';

class Network {
  static var client = http.Client();

  static get({required String url, headers, Map<String, dynamic>? params}) async {
    try{
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if(headers !=null){
        apiHeaders.addAll(headers);
      }

      Uri uri = Uri.https(Constants.baseURL, url, params);
      print("REQUESTED URL => $uri");
      var response = await client.get(uri, headers: apiHeaders);
      if(response.statusCode == 200) {
        return response.body;
        // return json.decode(response.body);
      }
      if(response.statusCode < 200 || response.statusCode > 400 || json == null) {
        return null;
      }
    } catch(e) {
      print("GET: $e");
      return throw Exception(e);
    }

    // if(response.statusCode != 403) {
    //   return json.decode(response.body);
    // } else {
    //   return null;
    // }
  }

  static post({url,payload,headers}) async {
    try{
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if(headers !=null){
        apiHeaders.addAll(headers);
      }
      var body = json.encode(payload);
      print(url);
      var response = await client.post(Uri.parse(url),body: body,headers:apiHeaders );
      if(response.statusCode == 200) {
        return response.body;
        // return json.decode(response.body);
      }
      if(response.statusCode < 200 || response.statusCode > 400 || json == null) {
        // return json.decode(response.body);
        return response.body;
        // return json.decode(response.body);
      }
    } catch(e){
      print("POST: $e");
      return throw Exception(e);
    }
  }

}