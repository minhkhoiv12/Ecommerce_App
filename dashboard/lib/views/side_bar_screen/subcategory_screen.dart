import 'package:dashboard_ecomerce/controllers/category_controller.dart';
import 'package:dashboard_ecomerce/controllers/subcategory_controller.dart';
import 'package:dashboard_ecomerce/models/category.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/widgets/subcategory_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subCategoryScreen'; 
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final SubcategoryController subcategoryController = SubcategoryController();
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  late Future<List<Category>> futureSubcategories;
  late String name;
  Category? selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSubcategories = CategoryController().loadCategories();
  }
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
                  'Danh mục con', 
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
            FutureBuilder(
              future: futureSubcategories, 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasError){
                  return Center(
                    child: Text('Lỗi ${snapshot.error}'),
                  );
                }
                else if(!snapshot.hasData|| snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Không có danh mục con nào'),
                  );
                }
                else{
                  return DropdownButton<Category>(
                    value: selectedCategory,
                    hint: const Text('Chọn danh mục'),
                    items: snapshot.data!.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        print(selectedCategory!.name);
                      });
                    },
                  );
                }
              }
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
                      child: _image !=null ? Image.memory(_image) : Text("Hình ảnh loại sản phẩm con",
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
                            return "Vui lòng nhập loại sản phẩm con";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Nhập tên loại sản phẩm con'
                        ),
                      ),
                    ),
                  ), 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: ()  async{ 
                      if(_formKey.currentState!.validate()) {
                        await subcategoryController.uploadSubcategory(categoryId: selectedCategory!.id, categoryName: selectedCategory!.name, pickedImage: _image, subCategoryName: name, context: context);
                        setState(() {
                          _formKey.currentState!.reset();
                          _image = null;
                        });
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  pickImage();
                   
                }, 
                child: Text(
                  "Chọn hình ảnh", 
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey,),
            SubcategoryWidget(),
          ],
        ),
      ),
    );
  }
}