import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:vendor/global_variables.dart';
import 'package:vendor/models/product.dart';
import 'package:vendor/services/manage_http_response.dart';

class ProductController {
  Future<void> uploadProduct({
    required String productName,
    required int productPrice,
    required int quantity,
    required String description,
    required String category,
    required String vendorId,
    required String fullName,
    required String subCategory,
    required List<File>? pickedImages,
    required BuildContext context,
  }) async {
    if(pickedImages !=null) {
      final cloudinary = CloudinaryPublic('dqtjhtikp', 'upload1');
      List<String> images = [];
      //loop through each image in the pickedImages list
      for(var i =0; i < pickedImages.length; i++) {
        // await the upload of the current image to cloudinary
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(CloudinaryFile.fromFile(pickedImages[i].path, folder: productName),);
       //add the secure Url to the images list
       images.add(cloudinaryResponse.secureUrl);
      }
      if(category.isNotEmpty && subCategory.isNotEmpty){
        final Product product = Product(
          id: '',
          productName: productName,
          productPrice: productPrice,
          quantity: quantity,
          description: description,
          category: category,
          vendorId: vendorId,
          fullName: fullName,
          subCategory: subCategory,
          images: images
        );
        http.Response response = await http.post(
          Uri.parse('$uri/api/add-product'),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        manageHttpResponse(response: response, context: context, onSuccess: (){
          showSnackBar(context, "Thêm sản phẩm thành công");
        });
      }
      else {
        showSnackBar(context, 'Chọn loại sản phẩm');
      }
    }
    else {
      showSnackBar(context, 'Chọn hình ảnh');
    }
     
    // Logic to upload product
  }
}