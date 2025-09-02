import 'package:bai1/models/product.dart';
import 'package:bai1/views/screens/detail/screens/product_detail_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends StatelessWidget {
  //const ProductItemWidget({super.key});
  final Product product;

  const ProductItemWidget({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailScreens(product: product);
        }));
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
                    Image.network(product.images[0], height: 170,
                    fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 2,
                      child: Image.asset(
                        'assets/icons/love.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset('assets/icons/cart.png',
                      width: 26,
                      height: 26,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.productName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 4),
              Text(product.category,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF757575),
                ),
              ),
              Text(
                "\$${product.productPrice.toStringAsFixed(2)}",
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