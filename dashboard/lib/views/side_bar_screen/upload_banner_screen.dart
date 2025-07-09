import 'package:dashboard_ecomerce/controllers/banner_controller.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/widgets/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBanner extends StatefulWidget {
   static const String id = '\banner-screen'; 
  const UploadBanner({super.key});

  @override
  State<UploadBanner> createState() => _UploadBannerState();
}

class _UploadBannerState extends State<UploadBanner> {
  final BannerController _bannerController = BannerController();
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
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Banners",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 2,
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
                child: _image !=null ? Image.memory(_image): const Text("Thêm banner",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async{
                await _bannerController.uploadCategory(pickedImage: _image, context: context);
              }, 
              child: Text("Lưu"),
              ),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            }, 
            child: Text('Thêm hình ảnh'),
            ),
        ),
        Divider(
          color: Colors.grey,
          
        ),
        BannerWidget(),
      ],
     );
  }
}