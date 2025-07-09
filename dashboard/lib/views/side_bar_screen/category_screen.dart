import 'package:dashboard_ecomerce/controllers/category_controller.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/widgets/category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
   static const String id = 'category-screen'; 
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController(); 
  late String name;
  dynamic _bannerImage;
  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if( result !=null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if( result !=null) {
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     return Form(
      key: _formKey,
       child: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Loại sản phẩm', 
                  style: TextStyle(
                    fontSize: 36, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5,),
                  ),
                  child: Center(
                    child: _image !=null ? Image.memory(_image) : Text("Ảnh loại sản phẩm",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        name= value;
                      },
                      validator: (value) {
                        if(value!.isNotEmpty) {
                          return null;
                        }
                        else {
                          return "Vui lòng nhập loại sản phẩm";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Nhập tên loại sản phẩm'
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){}, 
                  child: Text(
                    'cancel'
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: ()  async{
                    if(_formKey.currentState!.validate()) {
                      await _categoryController.uploadCategory(pickedImage: _image, pickedBanner: _bannerImage, name: name, context: context);
                    }
                  }, 
                    child: Text(
                      "Save", 
                      style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pickImage();
                }, 
                child: Text("Chọn hình ảnh"),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
             Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5,),
                ),
                child: Center(
                  child: _bannerImage !=null ? Image.memory(_bannerImage) : const Text("Thêm banner",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  pickBannerImage();
                }, 
                child: Text(
                  "Chọn hình ảnh", 
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            CategoryWidget(),
          ], 
               ),
       ),
    );
  }
}