import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/controllers/category_controller.dart';
import 'package:vendor/controllers/product_controller.dart';
import 'package:vendor/controllers/subcategory_controller.dart';
import 'package:vendor/models/category.dart';
import 'package:vendor/models/subcategory.dart';
import 'package:vendor/provider/vendor_provider.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProductController _productController = ProductController();  
  late Future<List<Category>> futureCategories;
  Future<List<Subcategory>>? futureSubcategories;
  late String name;
  Category? selectedCategory;
  Subcategory? selectedSubcategory;
  late String productName;
  late int productPrice;
  late int quantity;
  late String description;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  //Create an inatance of imagePicker to handle image selection
  final ImagePicker picker =ImagePicker();
  //initialize an empty list to store the selected images
  List<File> images = [];
  //Defind a function to choose image from the gallery
  chooseImage() async{
    // User the picker to select an image from the gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //check if no image was picked
    if(pickedFile == null) {
      print('Không có hình ảnh nào được chọn');
    }
    else {
      // if an image was picked, uodate the state and add the image to list
      setState(() {
        images.add(File(pickedFile.path));
      });
    }

  }
  getSubcategoryByCategory(value){
    // fetch subcategories based on the selected category
    futureSubcategories = SubcategoryController().getSubCategoriesByCategoryName(value.name);
    // reset the selected subcategory to null
    selectedSubcategory = null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: images.length+1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index){
                // if the index is 0, display an iconbutton to add a new image
                return index ==0 ? Center(
                  child: IconButton(
                    onPressed: chooseImage, icon: Icon(Icons.add),
                    ),
                ): SizedBox(
                  width: 50,
                  height: 40,
                  child: Image.file(images[index-1]),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) {
                          productName = value;
                        },
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Vui lòng nhập tên sản phẩm';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Nhập sản phẩm",
                          hintText: "Nhập tên sản phẩm",
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          productPrice = int.parse(value);
                        },
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Vui lòng nhập giá sản phẩm';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Nhập giá sản phẩm",
                          hintText: "Nhập giá sản phẩm",
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          quantity = int.parse(value);
                        },
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Vui lòng nhập số lượng sản phẩm';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Nhập số lượng sản phẩm",
                          hintText: "Nhập số lượng sản phẩm",
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        onChanged: (value) {
                          description = value;
                        },
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Vui lòng nhập mô tả sản phẩm';
                          }
                          return null;
                        },
                        maxLines: 3,
                        maxLength: 500,
                        decoration: const InputDecoration(
                          labelText: "Nhập mô tả sản phẩm",
                          hintText: "Nhập mô tả sản phẩm",
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: FutureBuilder(
                        future: futureCategories, 
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
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
                                 // print(selectedCategory!.name);
                                });
                                getSubcategoryByCategory(selectedCategory);
                              },
                            );
                          }
                        }
                      ),
                    ),
                     SizedBox(
                      width: 200,
                       child: FutureBuilder(
                        future: futureSubcategories, 
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
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
                            return DropdownButton<Subcategory>(
                              value: selectedSubcategory,
                              hint: const Text('Chọn danh mục con'),
                              items: snapshot.data!.map((Subcategory subcategory) {
                                return DropdownMenuItem<Subcategory>(
                                  value: subcategory,
                                  child: Text(subcategory.subCategoryName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedSubcategory = value;
                                 // print(selectedCategory!.name);
                                });
                               // getSubcategoryByCategory(selectedCategory);
                              },
                            );
                          }
                        }
                                       ),
                     ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () async {
                    final fullName = ref.read(vendorProvider)!.fullName;
                    final vendorId = ref.read(vendorProvider)!.id;
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                      isLoading = true;
                    });

                      // Call the upload function here
                      // UploadController().uploadProduct(name, price, quantity, description, selectedCategory, selectedSubcategory, images);
                      //print('Upload thành công');
                       await _productController.uploadProduct(productName: productName, productPrice: productPrice, quantity: quantity, description: description, category: selectedCategory!.name, vendorId: vendorId, fullName: fullName, subCategory: selectedSubcategory!.subCategoryName, pickedImages: images, context: context).whenComplete((){
                          setState(() {
                            isLoading = false;
                         });
                          selectedCategory = null;
                          selectedSubcategory = null;
                          images.clear();
                          });
                    } else {
                      print('Vui lòng điền đầy đủ thông tin');
                    }
        
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(5),
                      
                  ),
                  child: Center(child:
                    isLoading? const CircularProgressIndicator(color:Colors.white): const
                    Text(
                      "Tải sản phẩm lên",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.7,
                      ),
                    ),
                  ),
                            ),
                ),
            )
          ],
        ),
      ),
    );
  }
} 