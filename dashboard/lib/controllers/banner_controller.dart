
import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/banner.dart';
import 'package:dashboard_ecomerce/services/manager_http_response.dart';
import 'package:http/http.dart' as http;
class BannerController {
  uploadCategory({required dynamic pickedImage, required context,})async {
    try {
     final cloudinary = CloudinaryPublic('dqtjhtikp', 'upload1');
     CloudinaryResponse imageResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'banners'),
     );
//print(imageResponse);
      String image = imageResponse.secureUrl;
      BannerModel bannerModel = BannerModel(id: '', image: image);
      http.Response response = await http.post(Uri.parse('$uri/api/banner'),
        body: bannerModel.toJson(),// Convert the User object to JSON
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen()));
       
        showSnackBar(context, 'Tải banner lên thành công');
      });

    }
    catch(e){
      print('Lỗi upload lên cloudinary: $e');
    }
  }

  // fetch banners
    Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      print (response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      }
      else{
        //throw an exception if server responsed with an error status code
        throw Exception('Load banner thất bại');
      }
    }
    catch(e){
      throw Exception('Lỗi loading Banners $e');

    }
  }
}