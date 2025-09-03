
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor/controllers/order_controller.dart';
import 'package:vendor/models/order.dart';
import 'package:vendor/provider/oder_provider.dart';
import 'package:vendor/provider/vendor_provider.dart';
import 'package:vendor/views/screens/detail/screens/order_detail_screen.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState(){
    super.initState();
    _fetchOrders();
  }
  Future<void> _fetchOrders() async {
    final user = ref.read(vendorProvider);
    if(user !=null){
      final OrderController orderController = OrderController();
      try {
        final orders = await orderController.loadOrders(vendorId: user.id);
        ref.read(orderProvider.notifier).setOrders(orders);
      }
      catch (e){
        //Handle any errors that may occur during the fetch operation
        print("Lỗi xảy ra trong quá trình lấy dữ liệu đơn hàng: $e");
      }
    }
  }
  Future<void> _deleteOrder(String orderId) async{
    final OrderController orderController = OrderController();
    try {
      await orderController.deleteOrder(id: orderId, context: context);
      // Cập nhật trực tiếp provider để UI render lại ngay
      ref.read(orderProvider.notifier).removeOrder(orderId);
      //After deleting the order, refresh the orders list
     _fetchOrders();
    }
    catch (e){
      print("Lỗi xảy ra trong quá trình xóa đơn hàng: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);

    return Scaffold(
       appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), 
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:  AssetImage(
                'assets/icons/cartb.png'
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/not.png',
                      width: 25,
                      height: 25,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color:  Colors.yellow.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            orders.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                   'Đơn hàng của tôi',
                   style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                   ),
                  ),
                )
            ],
          )
        )
      ),
      body: orders.isEmpty? const Center(
        child: Text('Không tìm thấy đơn hàng nào',
        ),
      ):
      ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index){
          final Order order = orders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return OrderDetailScreen(order: order);
                }));
              },
              child: Container(
                width: 335,
                height: 153,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 336,
                          height: 154,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border: Border.all(
                              color: const Color(0xFFEFF0F2),
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 13,
                                top: 9,
                                child: Container(
                                  width: 78,
                                  height: 78,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBCC5FF),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 10,
                                        top: 5,
                                        child: Image.network(
                                          order.image,
                                          width: 58, 
                                          height: 67, 
                                          fit:BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 101,
                                top: 14,
                                child: SizedBox(
                                  width: 216,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  order.productName,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 4,),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  order.category,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF7F808C),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2,),
                                              Text(
                                                "\$${order.productPrice.toStringAsFixed(2)}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF0B0C1E),
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
                                left: 13,
                                top: 113,
                                child: Container(
                                  width: 100,
                                  height: 25,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: order.delivered==true? const Color(0xFF3C55EF): order.processing==true?Colors.purple:Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 9,
                                        top: 2,
                                        child: Text(
                                          order.delivered==true?"Đã giao": order.processing==true?"Đang xử lý":"Đã hủy",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1.3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                              order.delivered==true? Positioned(
                                top: 115,
                                left: 298,
                                child: InkWell(
                                  onTap: (){
                                    _deleteOrder(order.id);
                                  },
                                  child: Image.asset(
                                    'assets/icons/delete.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ):
                              SizedBox(),
                            ], 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}