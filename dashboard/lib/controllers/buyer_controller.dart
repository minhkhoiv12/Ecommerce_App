import 'dart:convert';

import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/buyer.dart';
import 'package:http/http.dart' as http;

class BuyerController {
  // fetch banners
    Future<List<Buyer>> loadBuyers() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/users'),
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      print (response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Buyer> buyers = data.map((buyer) => Buyer.fromMap(buyer)).toList();
        return buyers;
      }
      else{
        //throw an exception if server responsed with an error status code
        throw Exception('Load người dùng thất bại');
      }
    }
    catch(e){
      throw Exception('Lỗi loading người dùng $e');

    }
  }
}