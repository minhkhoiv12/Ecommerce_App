import 'dart:convert';

class Subcategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName;

  Subcategory({required this.id, required this.categoryId, required this.categoryName, required this.image, required this.subCategoryName});
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subCategoryName': subCategoryName,
    };
  }
  String toJson() => json.encode(toMap());// json.encode chuyển đổi từ object sang json
  // Khác với User(...), factory có thể kiểm tra, xử lý logic trước khi tạo object.
  //Đây là một tên constructor tùy chỉnh, có nhiệm vụ nhận dữ liệu dạng Map và chuyển thành một object User.
  factory Subcategory.fromJson(Map<String, dynamic> map) {
    return Subcategory(
      id: map['_id'] as String? ?? '',
      categoryId: map['categoryId'] as String? ?? '',
      categoryName: map['categoryName']as String? ?? '',
      image: map['image']as String? ?? '',
      subCategoryName: map['subCategoryName']as String? ?? '',
    );
  }
  
}