import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category({required this.id, required this.name, required this.image, required this.banner});
  //Serialization: Covert User Object to Map
  // why use Map, because Map is a key-value pair, and it is easy to convert to JSON.
  // json.endcode make good variable Map, List, boolean, int, double.....
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }
  
  String toJson() => json.encode(toMap());// json.encode chuyển đổi từ object sang json
  // Khác với User(...), factory có thể kiểm tra, xử lý logic trước khi tạo object.
  //Đây là một tên constructor tùy chỉnh, có nhiệm vụ nhận dữ liệu dạng Map và chuyển thành một object User.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      image: map['image']as String? ?? '',
      banner: map['banner']as String? ?? '',
    );
  }
  // fromJson: This factory contructor takes Json String , and decodes into a Map<String, dynamic>
  // and then uses fromMap to covert thap Map into a User object.
  factory Category.fromJson(String source) {
    return Category.fromMap(json.decode(source) as Map<String, dynamic>);//decode chuyển chuỗi JSON → Map/List
  }
  
} 