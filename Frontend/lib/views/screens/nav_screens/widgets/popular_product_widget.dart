import 'package:bai1/controllers/product_controller.dart';
import 'package:bai1/models/product.dart';
import 'package:bai1/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});

  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  //A Future that will hold the list of the popular products
  late Future<List<Product>> futurePopularProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularProducts = ProductController().loadPopularProducts();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePopularProducts, 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có sản phẩm phổ biến nào'));
        } else 
        {
          final products = snapshot.data;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
             // shrinkWrap: true,
             // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = products[index];
                //return Text(product.productName);
                return ProductItemWidget(product: product,);
            
              },
            ),
          );
        }
      });
  }
}