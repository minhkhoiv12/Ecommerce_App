

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/models/vendor.dart';
//StateNotifier: StateNotifier is a class provided by Riverpod package that helps in
// managging the state, it is also desined to notify listeners about the state changes. 
class VendorProvider extends StateNotifier<Vendor?> {
  VendorProvider() : super(Vendor(id: '', fullName: '', email: '', state: '', city: '', locality: '', role: '', password: ''));
  //Getter method to extract value from an object
  Vendor? get vendor => state;// tạo 1 getter để lấy giá trị của user từ state

  //method to set vendor user from json
  //purpose: updates the user sate base on json string representation of user Object
  void setVendor(String vendorJson) {//Cập nhật state người dùng dễ dàng
    state = Vendor.fromJson(vendorJson);// state nó giúp lưu vào bộ nhớ tạm thời trong máy 
  }
  // Method to clear user state
  void signOut() {
    state = null; // Đặt lại state người dùng về null khi đăng xuất
  }
  

}
// make the data accisible within the application
//Tạo một Provider toàn cục để quản lý và truy cập UserProvider trong toàn app
  final vendorProvider = StateNotifierProvider<VendorProvider, Vendor?>((ref) => VendorProvider() //Truy cập dễ dàng trong mọi màn hình
  );
//StateNotifierProvider<ClassQuảnLý, KiểuDữLiệuCủaState>
//ref (đối tượng giúp tương tác với các Provider khác nếu cần)