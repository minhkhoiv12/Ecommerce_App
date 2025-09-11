import 'dart:convert';
import 'package:bai1/models/user.dart';
import 'package:bai1/provider/delivered_order_count_provider.dart';
import 'package:bai1/provider/user_provider.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:bai1/views/screens/authentication_screens/login_screen.dart';
import 'package:bai1/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bai1/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      print('Xảy ra lỗi trong quá trình đăng ký: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }

  // Sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
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
        ref.read(userProvider.notifier).setUser(userJson);//Cập nhật trạng thái người dùng trong bộ nhớ (RAM)
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
      print('Có lỗi trong quá trình đăng nhập: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }
  //Sign out 
  Future<void> signOutUser({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreferences
      await preferences.remove('auth_token'); // Xóa token khỏi SharedPreferences
      await preferences.remove('user'); // Xóa user khỏi SharedPreferences
      //clear the user state
      ref.read(userProvider.notifier).signOut(); // Đặt lại trạng thái người dùng về null
      ref.read(deliveredOrderCountProvider.notifier).resetCount();

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
  //Update user state city and locality
    Future<void> updateUserLocation({
      required BuildContext context,
      required String id,
      required String state,
      required String city,
      required String locality,
      required WidgetRef ref,
    }) async {
      try {
        //make an HTTP PUT request to update user state, city and locality
        final http.Response response = await http.put(Uri.parse('$uri/api/users/$id'),
          //set the header for the request to specify that the content is Json
            headers: <String, String>{
              // Set the content type to application/json
              'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
          },
        //Encode the update data(state, city, and locality) AS json object
          body: jsonEncode({
            'state': state,
            'city': city,
            'locality': locality,
          }),
        );
        manageHttpResponse(response: response, context: context, onSuccess: () async{
          //Decode the updated user data from the response body
          //This converts the json String response into Dart Map
          final updateUser = jsonDecode(response.body);
          //Access Shared preference for local data storage
          //Shared preferences allow us to store data persisitently on the device
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Encode the update user data as json String 
          // This prepares the data for storage in shared preference
          final userJson = jsonEncode(updateUser);
          //update the application state with the updated user data user in Riverpod
          //this ensures the app reflects the most recent user data
          ref.read(userProvider.notifier).setUser(userJson);
          //store the updated user data in shared preference for future user
          //this allows the app to retrive the user data even after the app restarts
          await  preferences.setString('user', userJson);
        });
      }
      catch(e){
        //catch any error that occure during the process
        //show an error message to the user if the update fails
        showSnackBar(context, 'Lỗi cập nhật vị trí');
    }
  }
}