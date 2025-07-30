import 'package:bai1/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(User(id: '', fullName: '', email: '', state: '', city: '', locality: '', password: '', token: ''));
  //Getter method to extract value from an object
  User? get user => state;

  //method to set user from json
  //purpose: updates he user sate base on json string representation of user Object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }
  

}
// make the data accisible within the application
  final userProvider = StateNotifierProvider<UserProvider, User?>((ref) => UserProvider()
  );