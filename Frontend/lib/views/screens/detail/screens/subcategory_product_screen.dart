import 'package:bai1/controllers/product_controller.dart';
import 'package:bai1/models/subcategory.dart';
import 'package:bai1/provider/subcategory_product_provider.dart';
import 'package:bai1/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProductScreen extends ConsumerStatefulWidget {
  final Subcategory subcategory;

  const SubcategoryProductScreen({super.key, required this.subcategory});

  @override
  ConsumerState<SubcategoryProductScreen> createState() => _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState extends ConsumerState<SubcategoryProductScreen> {
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
      final products = await productController.loadProductsBySubcategory(widget.subcategory.subCategoryName);
      if (!mounted) return; // ✅ kiểm tra widget còn mounted không
      ref.read(subcategoryProductProvider.notifier).setProducts(products);
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
    final products = ref.watch(subcategoryProductProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    //set the number of colume in grid base on the width
    //if the screen with is less than 600 pixels, use columns
    //if the screen is 600 pixels or more, use 4 column
    final crossAxisCount = screenWidth<600?2:4;
    //set the aspect ration(width-to-height ration) of each gride item base on the screen width
    //for smaller screen(<600 pixels) use a ration of 3.4(taller items)
    //for larger screen(>=600 pixels), use a ratio of 4.5(more square-shaped items)
    final childAspectRatio = screenWidth<600?3/4: 4/5;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subcategory.subCategoryName),
      ),
      body: isLoading?const Center(child: CircularProgressIndicator(color: Colors.blue,),):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio, mainAxisSpacing: 8, crossAxisSpacing: 8), itemBuilder: (context, index){
            final product = products[index];
            return ProductItemWidget(product: product);
          }),
      )
    );
  }
}