import 'dart:convert';

import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/order.dart';
import 'package:http/http.dart' as http;
class OrderController {
  Future<List<Order>> loadOrders() async {
    try {
      //send an http request to fetch the list of orders from the server
      http.Response response = await http.get(Uri.parse('$uri/api/orders'),
        //set headers to speacify content type as json, ensuring proper encoding and communication
        //why: the server expectes requests to specify the data formate, and in this, we are using json format
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
        },
      );
      //check if the http response status code is 200, meaning the request was successfull
      //why: HTTP status code indicates whether the request succeed or failed, mean
      if(response.statusCode==200){
        //decode the json response body into list of dynamic object
        //why: the server returns data as json string, so we must convert it to usable dart list
        List<dynamic> data = jsonDecode(response.body);
        //convert the dynamic list into list of oder objects
        //why: Mapping each json object into an Order Object, allows us to work with structured data in dart
       List<Order> orders = data.map((order)=>Order.fromJson(order)).toList();
       return orders;
      }
      else {
        throw Exception('Không tải được danh sách đơn hàng');
      }
    }
    catch(e){
      throw Exception('Sự cố khi lấy dữ liệu của đơn hàng: $e');
    }
  }
}