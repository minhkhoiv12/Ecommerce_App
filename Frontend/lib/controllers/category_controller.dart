import 'dart:convert';
import 'package:bai1/global_variables.dart';
import 'package:bai1/models/category.dart';
import 'package:http/http.dart' as http;
class CategoryController {
  Future<List<Category>> loadCategories() async {
    try {
      // send an http get request to load categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if(response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data.map((category) => Category.fromJson(category)).toList();
        return categories;
      }
      else if(response.statusCode ==404){
        return [];
      }
      else {
        throw Exception('Load sản phẩm thất bại');
      }
    }
    catch (e) {
     throw Exception('Lỗi tải loại sản phẩm: $e');
    }
  }
}



