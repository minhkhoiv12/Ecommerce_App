
import 'package:bai1/controllers/banner_controller.dart';
import 'package:bai1/models/banner_model.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
   // A Future that will hold the list of bannes once loaded from api
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanners = BannerController().loadBanners();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FutureBuilder(future: futureBanners, builder: (context, snapshot){
    if(snapshot.connectionState== ConnectionState.waiting){
      return CircularProgressIndicator();
    
    }
    else if(snapshot.hasError){
      return Center(child: Text("Lỗi: ${snapshot.error}"),
      );
    }
    else if(!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('Không có banner nào '),
      );
    }
    else {
      final banners = snapshot.data!;
      return PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              banner.image, 
              fit: BoxFit.cover
              ),
          );
    
        });
        
    }
        }),
    );
  }
}