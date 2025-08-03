import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
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
                onPressed: (){}, icon: Icon(Icons.add),
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
                    decoration:  InputDecoration(
                      labelText: "Nhập sản phẩm",
                      hintText: "Nhập tên sản phẩm",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: "Nhập giá sản phẩm",
                      hintText: "Nhập giá sản phẩm",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: "Nhập số lượng sản phẩm",
                      hintText: "Nhập số lượng sản phẩm",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    maxLines: 3,
                    maxLength: 500,
                    decoration:  InputDecoration(
                      labelText: "Nhập mô tả sản phẩm",
                      hintText: "Nhập mô tả sản phẩm",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
} 