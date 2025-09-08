import 'dart:convert';

class Buyer {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  Buyer({required this.id, required this.fullName, required this.email, required this.state, required this.city, required this.locality, required this.password, required this.token});
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
      'password': password,
      'token': token,
    };
  }
  
  String toJson() => json.encode(toMap());// json.encode chuyển đổi từ object sang json
  // Khác với User(...), factory có thể kiểm tra, xử lý logic trước khi tạo object.
  //Đây là một tên constructor tùy chỉnh, có nhiệm vụ nhận dữ liệu dạng Map và chuyển thành một object User.
  factory Buyer.fromMap(Map<String, dynamic> map) {
    return Buyer(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email']as String? ?? '',
      state: map['state']as String? ?? '',
      city: map['city']as String? ?? '',
      locality: map['locality']as String? ?? '',
      password: map['password']as String? ?? '',
      token: map['token']as String? ?? '',
    );
  }
  
  
}
