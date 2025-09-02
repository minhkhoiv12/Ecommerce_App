import 'package:bai1/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(User(id: '', fullName: '', email: '', state: '', city: '', locality: '', password: '', token: ''));
  //Getter method to extract value from an object
  User? get user => state;// tạo 1 getter để lấy giá trị của user từ state

  //method to set user from json
  //purpose: updates he user sate base on json string representation of user Object
  void setUser(String userJson) {//Cập nhật state người dùng dễ dàng
    state = User.fromJson(userJson);// state nó giúp lưu vào bộ nhớ tạm thời trong máy 
  }
  // Method to clear user state
  void signOut() {
    state = null; // Đặt lại state người dùng về null khi đăng xuất
  }
  //Method to Recreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality
  }){
    if(this.state !=null){
      this.state = User(
        id: this.state!.id, //Preserver the existing user id
        fullName: this.state!.fullName, //preserver the existing fullName
        email: this.state!.email, 
        state: state, 
        city: city, 
        locality: locality, 
        password: this.state!.password, //preserver the existing password
        token: this.state!.token //preserver the existing token
      );
    }
  }
  
}
// make the data accisible within the application
//Tạo một Provider toàn cục để quản lý và truy cập UserProvider trong toàn app
  final userProvider = StateNotifierProvider<UserProvider, User?>((ref) => UserProvider() //Truy cập dễ dàng trong mọi màn hình
  );
//StateNotifierProvider<ClassQuảnLý, KiểuDữLiệuCủaState>
//ref (đối tượng giúp tương tác với các Provider khác nếu cần)