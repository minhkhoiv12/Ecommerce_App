import 'dart:convert';

import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/vendor.dart';
import 'package:http/http.dart' as http;

class VendorController {
  // fetch banners
    Future<List<Vendor>> loadVendors() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/vendors'),
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      print (response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Vendor> vendors = data.map((vendor) => Vendor.fromMap(vendor)).toList();
        return vendors;
      }
      else{
        //throw an exception if server responsed with an error status code
        throw Exception('Load người bán thất bại');
      }
    }
    catch(e){
      throw Exception('Lỗi loading người bán $e');

    }
  }
}