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
  //A Future that will hold the list of the popular products
  // late Future<List<Product>> futurePopularProducts;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
    
  }

   Future<void> _fetchProduct() async {
    final productController = ProductController();
    try {
      final products = await productController.loadPopularProducts();
      if (!mounted) return; // ✅ kiểm tra widget còn mounted không
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print("Error fetching popular products: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: isLoading? const Center(child: CircularProgressIndicator(color: Colors.blue,)):
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
