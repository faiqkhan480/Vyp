import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  static var client = http.Client();

  static get({url,headers}) async {
    try{
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if(headers !=null){
        apiHeaders.addAll(headers);
      }
      print("REQUESTED URL => $url");
      var response = await client.get(Uri.parse(url.toString()),headers: apiHeaders);
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