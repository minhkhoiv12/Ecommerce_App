import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void manageHttpResponse({
  required http.Response response,// http response from the request
  required BuildContext context, // the context is to show snackbar
  required VoidCallback onSuccess, // callback function when the request is successful
}){
  // Switch statement to handle different status codes
  switch(response.statusCode){
    case 200: 
      onSuccess(); // Call the success callback if status code is 200
      break;
    case 400: // staus code 400 indicates a bad request
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500:
    //Map<String, dynamic> decoded = json.decode(response.body);
    //var error = decoded['error'];
    showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: // status code 201 indicates a resource was created successfully
      onSuccess(); // Call the success callback if status code is 201
      break;

      

    
  }

}
// BuildContext context: Vị trí của widget đang gọi hàm — để biết phải hiển thị SnackBar ở đâu
//ScaffoldMessenger là ông quản lý SnackBar — giúp hiển thị, ẩn, chuyển đổi các SnackBar.
void showSnackBar(BuildContext context, String title){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey,
      content: Text(title),
    )
  );

}