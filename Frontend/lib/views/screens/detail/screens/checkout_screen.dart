
import 'package:bai1/controllers/order_controller.dart';
import 'package:bai1/provider/cart_provider.dart';
import 'package:bai1/provider/user_provider.dart';
import 'package:bai1/views/screens/detail/screens/shipping_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPaymentMethod = 'stripe';
  final OrderController _orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    final cartData = ref.read(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(
          horizontal: 25, 
          vertical: 15,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ShippingAdressScreen();
                  }));
                },
                child: SizedBox(
                  width: 335,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:  const Color(0xFFEFF0F2,),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -1,
                                left: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 114,
                                          child: Text(
                                            'Thêm địa chỉ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'VietNam',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.3,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Nhập tên thành phố',
                                          style: GoogleFonts.lato(
                                            color: const Color(0xFF7F808C),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child:Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBF7F5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.network(
                                          width: 26,
                                          height: 26,
                                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ],
                          ),

                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 25,
                        child: 
                        Image.network(
                          width: 20,
                          height: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                        ),
                      ),
                    ],
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Sản phẩm của bạn',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: cartData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    final cartItem = cartData.values.toList()[index];
                    return InkWell(
                      onTap: (){},
                      child: Container(
                        width: 336,
                        height: 91,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2)
                          ), 
                          borderRadius: BorderRadius.circular(12),

                        ),
                        child: Stack(
                          clipBehavior:  Clip.none,
                          children: [
                            Positioned(
                              left: 6,
                              top: 6,
                              child: SizedBox(
                                width: 311,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFBCC5FF)
                                      ),
                                      child: Image.network(cartItem.image[0],
                                       fit: BoxFit.cover,
                                      ),

                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 78,
                                        alignment: Alignment(0, -0.51),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  cartItem.productName,
                                                  style: GoogleFonts.quicksand(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  cartItem.category,
                                                  style: GoogleFonts.lato(
                                                    color: Colors.blueGrey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text("\$${cartItem.productPrice.toStringAsFixed(2)}",
                                      style: GoogleFonts.robotoSerif(
                                        fontSize: 14,
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Chọn phương thức thanh toán',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioListTile<String>(
                  title: Text('Stripe',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  value: 'stripe', 
                  groupValue: selectedPaymentMethod, 
                  onChanged: (String? value){
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  }
                ),
                RadioListTile<String>(
                 // subtitle: Icon(Icons.delivery_dining),
                  title: Text('tiền mặt',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  value: 'tiền mặt', 
                  groupValue: selectedPaymentMethod, 
                  onChanged: (String? value){
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ref.read(userProvider)!.state==""?TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const ShippingAdressScreen();
            }));
          }, 
          child: Text("Vui lòng nhập địa chỉ của bạn",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 17,

            ),
          )
        ): 
        InkWell(
          onTap: () async{
            if(selectedPaymentMethod=='stripe'){
              //pay with stripe to place the order

            }
            else {
              await Future.forEach(_cartProvider.getCartItems.entries, (entry){
                var item = entry.value;
               _orderController.uploadOrders(
                  id: '', 
                  fullName: ref.read(userProvider)!.fullName, 
                  email: ref.read(userProvider)!.email, 
                  state: 'VietNam', 
                  city: 'Thành Phố Hồ Chí Minh', 
                  locality: 'Test', 
                  productName: item.productName, 
                  productPrice: item.productPrice, 
                  quantity: item.quantity, 
                  category: item.category, 
                  image: item.image[0], 
                  buyerId: ref.read(userProvider)!.id, 
                  vendorId: item.vendorId, 
                  processing: true, 
                  delivered: false, 
                  context: context);
              });
            }
          },
          child: Container(
            width: 338,
            height: 58,
            decoration: BoxDecoration(
              color:const  Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(selectedPaymentMethod=='stripe'?'Thanh toán ngay': 'Đặt hàng',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
          
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}