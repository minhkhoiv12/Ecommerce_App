import 'package:flutter/material.dart';

class InnerBannerWidget extends StatelessWidget {
  final String image;

  const InnerBannerWidget({super.key, required this.image});
  //const InnerBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(// cat thành hình chu nhat
          borderRadius: BorderRadius.circular(8.0), // Add border radius for rounded corners
          child: Image.network(image, fit: BoxFit.cover,),
        ),
        
      ),
    );
  }
}