import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dashboard_ecomerce/global_variables.dart';
import 'package:dashboard_ecomerce/models/subcategory.dart';
import 'package:dashboard_ecomerce/services/manager_http_response.dart';
import 'package:http/http.dart' as http;
class SubcategoryController {
  uploadSubcategory({required String categoryId, required String categoryName, required dynamic pickedImage, required String subCategoryName, required context}) async{
    try{
      final cloudinary = CloudinaryPublic('dqtjhtikp', 'upload1');
       CloudinaryResponse imageResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'categoryImages'),
     );
//print(imageResponse);
      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(id: '', categoryId: categoryId, categoryName: categoryName, image: image, subCategoryName: subCategoryName);
      http.Response response = await http.post(Uri.parse('$uri/api/subcategories'),
        body: subcategory.toJson(),// Convert the User object to JSON
        headers: <String, String>{
          // Set the content type to application/json
          'Content-Type': 'application/json; charset=UTF-8', // specify the content type as Json
       }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen()));
       
        showSnackBar(context, 'Tải thành công danh mục sản phẩm con');
      });
    }
    catch(e){
      print("$e");

    }
  }
}