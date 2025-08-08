
import 'dart:convert';

import 'package:bai1/global_variables.dart';
import 'package:bai1/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  //Define the function that returns a future containing list of the product model objects
  Future<List<Product>> loadPopularProducts() async {
    // use a try block to handle any exceptions that might occur in the http request process
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/popular-products"),
        //set the http headers for the request, specifying that the content type is json with the UTF-8 encoding
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //check if the Http response status code is 200, which means t he request was successfull
      if(response.statusCode == 200){
        //Decode the json response body into a list of dynamic objects
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //map each items in the list to product model object which we can use 
        List<Product> products = data.map((product)=> Product.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }
      else {
        //if status code is not 200, throw an exeption  indicating failure to load the popular products
        throw Exception('Thất bại khi tải sản phẩm phổ biến');
      }
    }
    catch (e){
      throw Exception('Lỗi khi tải sản phẩm phổ biến: $e');

    }
  }
  // load product by category function 
  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/products-by-category/$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        //Decode the json response body into a list of dynamic objects
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //map each items in the list to product model object which we can use 
        List<Product> products = data.map((product)=> Product.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }
      else {
        //if status code is not 200, throw an exeption  indicating failure to load the popular products
        throw Exception('Thất bại khi tải sản phẩm phổ biến');
      }
    }
    catch (e) {
      throw Exception('Lỗi khi tải sản phẩm theo danh mục: $e');
    }
  }
}