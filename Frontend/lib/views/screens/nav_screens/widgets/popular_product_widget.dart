import 'package:bai1/controllers/product_controller.dart';
import 'package:bai1/provider/product_provider.dart';
import 'package:bai1/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() =>
      _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  bool isLoading = true;
  //A Future that will hold the list of the popular products
  // late Future<List<Product>> futurePopularProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final products = ref.read(productProvider);
    if(products.isEmpty){
      _fetchProduct();
    }
    else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadPopularProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print("$e");
    } finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: isLoading? const Center(child: CircularProgressIndicator(color: Colors.blue)) :
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final product = products[index];
          //return Text(product.productName);
          return ProductItemWidget(product: product);
        },
      ),
    );
  }
}
