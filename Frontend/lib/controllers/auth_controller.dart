import 'dart:convert';
import 'package:bai1/models/user.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:bai1/views/screens/authentication_screens/login_screen.dart';
import 'package:bai1/views/screens/authentication_screens/register_screen.dart';
import 'package:bai1/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bai1/global_variables.dart';
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
      manageHttpResponse(response: response, context: context, onSuccess: () {
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
}