import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendor/global_variables.dart';
import 'package:vendor/models/subcategory.dart';
class SubcategoryController {
  Future<List<Subcategory>> getSubCategoriesByCategoryName(String categoryName) async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/category/$categoryName/subcategories"),
       headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode==200){
        final List<dynamic> data =jsonDecode(response.body);
        if(data.isNotEmpty) {
          return data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        }
        else{
          print("Không tìm thấy danh mục con nào!");
          return [];
        }
      }
      else if(response.statusCode == 404){
         print("Không tìm thấy danh mục con nào!");
         return [];
      }
      else {
         print("Không thể tìm được danh mục con!");
         return [];
      }
    }
    catch (e){
      print("Lỗi không thể tìm thấy danh mục con");
      return [];
    }
  }
}