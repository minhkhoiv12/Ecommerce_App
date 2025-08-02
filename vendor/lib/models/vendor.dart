import 'dart:convert';

class Vendor {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String role;
  final String password;
  Vendor({required this.id, required this.fullName, required this.email, required this.state, required this.city, required this.locality, required this.role, required this.password});

  //Serialization: Covert User Object to Map
  // why use Map, because Map is a key-value pair, and it is easy to convert to JSON.
  // json.endcode make good variable Map, List, boolean, int, double.....
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'role': role,
      'password': password,
    };
  }
  
  String toJson() => json.encode(toMap());// json.encode chuyển đổi từ object sang json
  // Khác với User(...), factory có thể kiểm tra, xử lý logic trước khi tạo object.
  //Đây là một tên constructor tùy chỉnh, có nhiệm vụ nhận dữ liệu dạng Map và chuyển thành một object User.
  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email']as String? ?? '',
      state: map['state']as String? ?? '',
      city: map['city']as String? ?? '',
      locality: map['locality']as String? ?? '',
      role: map['role']as String? ?? '',
      password: map['password']as String? ?? '',
     
    );
  }
  // fromJson: This factory contructor takes Json String , and decodes into a Map<String, dynamic>
  // and then uses fromMap to covert thap Map into a User object.
  // factory Vendor.fromJson(String source) {
  //   return Vendor.fromMap(json.decode(source) as Map<String, dynamic>);//decode chuyển chuỗi JSON → Map/List
  // }

  
  
}
