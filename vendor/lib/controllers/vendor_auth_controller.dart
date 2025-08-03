

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/global_variables.dart';
import 'package:vendor/models/vendor.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/provider/vendor_provider.dart';
import 'package:vendor/services/manage_http_response.dart';
import 'package:vendor/views/screens/authentication/login_screen.dart';
import 'package:vendor/views/screens/main_vendor_screen.dart';
final ProviderContainer providerContainer = ProviderContainer();
class VendorAuthController {
  Future<void> signUpVendor({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password
  })async {
    try
    {
      Vendor vendor = Vendor(
        id: '', 
        fullName: fullName, 
        email: email, 
        state: '', 
        city: '', 
        locality: '', 
        role: '', 
        password: password
      ); 
      http.Response response = await http.post(Uri.parse('$uri/api/vendor/signup'),
        body: vendor.toJson(),// Convert the Vendor object to JSON
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainVendorScreen()),
          (route) => false,
        );
       
        showSnackBar(context, 'Account has been created for you');
      });
    } 
    catch (e) {
      // Handle any exceptions that occur during the sign-up process
     // print('Error during sign-up: $e');
      // You can show a snackbar or dialog to inform the user about the error
      showSnackBar(context, '$e');
    }
  }

  // Sign in user
  Future<void> signInVendor({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      Vendor vendor = Vendor(
        id: '', 
        fullName: '', 
        email: email, 
        state: '', 
        city: '', 
        locality: '', 
        role: '', 
        password: password
      );
      http.Response response = await http.post(Uri.parse('$uri/api/vendor/signin'),
        body: jsonEncode({
          'email': vendor.email, // Use the email from the User object
          'password': vendor.password, // Use the password from the User object
        }), // Convert the User object to JSON
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
        }
      );
      manageHttpResponse(response: response, context: context, onSuccess: () async {
        //Access sharedPreferences for token and user data storage
        // Khởi tạo sharedPreferences 
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // Extract the authentication token from the response
        String token = jsonDecode(response.body)['token'];
        // Store the authentication token securely in SharedPreferences
        await preferences.setString('auth_token', token);//Lưu token vào SharedPreferences
        //Encode the user data recived from the backend as json
        final vendorJson = jsonEncode(jsonDecode(response.body)['vendor']);
        //update the application state with the user data using Riverpod
        providerContainer.read(vendorProvider.notifier).setVendor(vendorJson);//Cập nhật trạng thái người dùng trong bộ nhớ (RAM)
        // providerContainer object quản lý toàn bộ các provider trong ứng dụng 
        // .read(...) Đọc dữ liệu từ một provider cụ thể
        // .notifier Truy cập vào logic bên trong UserProvider (nơi có method setUser(...))
        // .setUser(userJson) Gọi method setUser để cập nhật trạng thái của User trong app
        //store the data in sharePreferences for future use
        await preferences.setString('vendor', vendorJson);//Lưu userJson vào SharedPreferences để dùng lại sau khi mở lại app
        //SharedPreferences không lưu được Map, phải chuyển thành String trước
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainVendorScreen()),
          (route) => false,
        );
        showSnackBar(context, 'Login');
      });

    }
    catch (e) {
      // Handle any exceptions that occur during the sign-in process
      //print('Error during sign-in: $e');
      // You can show a snackbar or dialog to inform the user about the error
      showSnackBar(context, '$e');
    }
  }
  //Sign out 
  // Future<void> signOutUser({
  //   required BuildContext context
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     //clear the token and user from SharedPreferences
  //     await preferences.remove('auth_token'); // Xóa token khỏi SharedPreferences
  //     await preferences.remove('user'); // Xóa user khỏi SharedPreferences
  //     //clear the user state
  //     providerContainer.read(userProvider.notifier).signOut(); // Đặt lại trạng thái người dùng về null
  //     //navigate the user back to the login screen
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //       (route) => false,
  //     );
  //     showSnackBar(context, 'Đăng xuất thành công');

  //   }
  //   catch (e) {
  //    showSnackBar(context, 'Lỗi khi đăng xuất');
  //   }
  // }
}