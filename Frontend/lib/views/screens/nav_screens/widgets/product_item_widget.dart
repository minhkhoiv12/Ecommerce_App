import 'package:bai1/models/product.dart';
import 'package:bai1/provider/cart_provider.dart';
import 'package:bai1/provider/favorite_provider.dart';
import 'package:bai1/services/manager_http_response.dart';
import 'package:bai1/views/screens/detail/screens/product_detail_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  //const ProductItemWidget({super.key});
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreens(product: widget.product);
            },
          ),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF2F2F2),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      widget.product.images[0],
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          favoriteProviderData.addProductToFavorite(
                            productName: widget.product.productName,
                            productPrice: widget.product.productPrice,
                            category: widget.product.category,
                            image: widget.product.images,
                            vendorId: widget.product.vendorId,
                            productQuantity: widget.product.quantity,
                            quantity: 1,
                            productId: widget.product.id,
                            description: widget.product.description,
                            fullName: widget.product.fullName,
                          );
                          showSnackBar(
                            context,
                            'Đã thêm ${widget.product.productName}',
                          );
                        },
                        child:
                            favoriteProviderData.getFavoriteItems.containsKey(
                              widget.product.id,
                            )
                            ? Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: isInCart
                            ? null
                            : () {
                                cartProviderData.addProductToCart(
                                  productName: widget.product.productName,
                                  productPrice: widget.product.productPrice,
                                  category: widget.product.category,
                                  image: widget.product.images,
                                  vendorId: widget.product.vendorId,
                                  productQuantity: widget.product.quantity,
                                  quantity: 1,
                                  productId: widget.product.id,
                                  description: widget.product.description,
                                  fullName: widget.product.fullName,
                                );
                                showSnackBar(
                                  context,
                                  widget.product.productName,
                                );
                              },
                        child: Image.asset(
                          'assets/icons/cart.png',
                          width: 26,
                          height: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                widget.product.productName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              widget.product.averageRating == 0
                  ? SizedBox()
                  : Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          widget.product.averageRating.toStringAsFixed(1),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

              Text(
                widget.product.category,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF757575),
                ),
              ),
              Text(
                "\$${widget.product.productPrice.toStringAsFixed(2)}",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
