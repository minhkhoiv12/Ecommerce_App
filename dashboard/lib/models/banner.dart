import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({required this.id, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'image': image,
    };
  }
  
  String toJson() => json.encode(toMap());// json.encode chuyển đổi từ object sang json
  // Khác với User(...), factory có thể kiểm tra, xử lý logic trước khi tạo object.
  //Đây là một tên constructor tùy chỉnh, có nhiệm vụ nhận dữ liệu dạng Map và chuyển thành một object User.
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String? ?? '',
      image: map['image']as String? ?? '',
    );
  }
  // fromJson: This factory contructor takes Json String , and decodes into a Map<String, dynamic>
  // and then uses fromMap to covert thap Map into a User object.
  factory BannerModel.fromJson(String source) {
    return BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);//decode chuyển chuỗi JSON → Map/List
  }

}