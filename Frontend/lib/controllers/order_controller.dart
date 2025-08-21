import 'package:bai1/global_variables.dart';
import 'package:bai1/models/order.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class OrderController {
  //function to upload orders
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required BuildContext context,
  }) async{
    try {
      final Order order = Order(id: id, fullName: fullName, email: email, state: state, city: city, locality: locality, productName: productName, productPrice: productPrice, quantity: quantity, category: category, image: image, buyerId: buyerId, vendorId: vendorId, processing: processing, delivered: delivered);
      http.Response response = await http.post(Uri.parse("$uri/api/orders"),
        body: order.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Bạn đã đặt hàng thành công');
      });
    }
    catch (e){
      showSnackBar(context, e.toString());
    }

  }
}