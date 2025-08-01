import 'dart:convert';
import 'package:bai1/models/user.dart';
import 'package:bai1/provider/user_provider.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:bai1/views/screens/authentication_screens/login_screen.dart';
import 'package:bai1/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bai1/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
final providerContainer = ProviderContainer();
class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  })async {
    try
    {

      User user =User(id: '', fullName: fullName, email: email, state: '', city: '', locality: '', password: password, token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
        body: user.toJson(),// Convert the User object to JSON
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
       
        showSnackBar(context, 'Account has been created for you');
      });
    } 
    catch (e) {
      // Handle any exceptions that occur during the sign-up process
      print('Error during sign-up: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }

  // Sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      User user = User(id: '', fullName: '', email: email, state: '', city: '', locality: '', password: password, token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': user.email, // Use the email from the User object
          'password': user.password, // Use the password from the User object
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
        final userJson = jsonEncode(jsonDecode(response.body)['user']);
        //update the application state with the user data using Riverpod
        providerContainer.read(userProvider.notifier).setUser(userJson);//Cập nhật trạng thái người dùng trong bộ nhớ (RAM)
        // providerContainer object quản lý toàn bộ các provider trong ứng dụng 
        // .read(...) Đọc dữ liệu từ một provider cụ thể
        // .notifier Truy cập vào logic bên trong UserProvider (nơi có method setUser(...))
        // .setUser(userJson) Gọi method setUser để cập nhật trạng thái của User trong app
        //store the data in sharePreferences for future use
        await preferences.setString('user', userJson);//Lưu userJson vào SharedPreferences để dùng lại sau khi mở lại app
        //SharedPreferences không lưu được Map, phải chuyển thành String trước
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
        showSnackBar(context, 'Login');
      });

    }
    catch (e) {
      // Handle any exceptions that occur during the sign-in process
      print('Error during sign-in: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }
  //Sign out 
  Future<void> signOutUser({
    required BuildContext context
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreferences
      await preferences.remove('auth_token'); // Xóa token khỏi SharedPreferences
      await preferences.remove('user'); // Xóa user khỏi SharedPreferences
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut(); // Đặt lại trạng thái người dùng về null
      //navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      showSnackBar(context, 'Đăng xuất thành công');

    }
    catch (e) {
     showSnackBar(context, 'Lỗi khi đăng xuất');
    }
  }
}