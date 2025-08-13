import 'package:bai1/models/product.dart';
import 'package:bai1/provider/cart_provider.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreens extends ConsumerStatefulWidget {
  //const ProductDetailScreens({super.key});
  final Product product;

  const ProductDetailScreens({super.key, required this.product}); 
  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreensState createState() => _ProductDetailScreensState();
}

class _ProductDetailScreensState extends ConsumerState<ProductDetailScreens> {
  @override
  Widget build(BuildContext context) { 
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết sản phẩm',
          style:  GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 50,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DDFF),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ), 
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: widget.product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return Image.network(widget.product.images[index],
                              width: 198,
                              height: 22,
                              fit: BoxFit.cover,
                            );
                          }),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color:const Color(0xFF3C55Ef),
                  ),
                ),
                Text("\$${widget.product.productPrice}",
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color:const Color(0xFF3C55Ef),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.category,
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mô tả",
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    letterSpacing: 1.7,
                    color:const Color(0xFF363330),
                  ),
                ),
                Text(widget.product.description,
                  style: GoogleFonts.lato(
                    letterSpacing: 1.7,
                    fontSize: 15,
                  ),
                ), 
              ],
              
            ),
    
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            _cartProvider.addProductToCart(productName: widget.product.productName, productPrice: widget.product.productPrice, category: widget.product.category, image: widget.product.images, vendorId: widget.product.vendorId, productQuantity: widget.product.quantity, quantity: 1, productId: widget.product.id, description: widget.product.description, fullName: widget.product.fullName);
            showSnackBar(context, widget.product.productName);
          },
          child: Container(
            height: 46,
            width: 386,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text("Thêm vào giỏ hàng",
              style: GoogleFonts.mochiyPopOne(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        ),
      ),
    );
  }
}