import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/category.dart';
import 'package:dashboard_ecomerce/services/manager_http_response.dart';
import 'package:http/http.dart' as http;
class CategoryController {
  uploadCategory({required dynamic pickedImage, required dynamic pickedBanner, required String name, required context,})async {
    try {
     final cloudinary = CloudinaryPublic('dqtjhtikp', 'upload1');
     CloudinaryResponse imageResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'categoryImages'),
     );
//print(imageResponse);
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedBanner, identifier: 'pickedBanner', folder: 'categoryImages'),
     );
     String banner = bannerResponse.secureUrl;
     //print(bannerResponse);
     Category category = Category(id: '', name: name, image: image, banner: banner);
     http.Response response = await http.post(Uri.parse('$uri/api/categories'),
        body: category.toJson(),// Convert the User object to JSON
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen()));
       
        showSnackBar(context, 'Tải thành công loại sản phẩm');
      });

    }
    catch(e){
      print('Lỗi upload lên cloudinary: $e');
    }
  }
  Future<List<Category>> loadCategories() async {
    try {
      // send an http get request to load categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if(response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data.map((category) => Category.fromJson(category)).toList();
        return categories;
      }
      else {
        throw Exception('Load sản phẩm thất bại');
      }
    }
    catch (e) {
     throw Exception('Lỗi tải loại sản phẩm: $e');
    }
  }
}



