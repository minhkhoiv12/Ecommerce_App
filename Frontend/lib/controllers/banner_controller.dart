
import 'dart:convert';


import 'package:bai1/global_variables.dart';
import 'package:bai1/models/banner_model.dart';
import 'package:http/http.dart' as http;
class BannerController {
  // fetch banners
    Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      print (response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      }
      else{
        //throw an exception if server responsed with an error status code
        throw Exception('Load banner thất bại');
      }
    }
    catch(e){
      throw Exception('Lỗi loading Banners $e');

    }
  }
}