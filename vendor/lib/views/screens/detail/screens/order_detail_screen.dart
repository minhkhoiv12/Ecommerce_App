import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor/controllers/order_controller.dart';
import 'package:vendor/models/order.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  OrderDetailScreen({super.key, required this.order});
  final OrderController orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.productName,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
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
                        border: Border.all(color: const Color(0xFFEFF0F2)),
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
                                      fit: BoxFit.cover,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                          const SizedBox(height: 4),
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
                                          const SizedBox(height: 2),
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
                                color: order.delivered == true
                                    ? const Color(0xFF3C55EF)
                                    : order.processing == true
                                    ? Colors.purple
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 9,
                                    top: 2,
                                    child: Text(
                                      order.delivered == true
                                          ? "Đã giao"
                                          : order.processing == true
                                          ? "Đang xử lý"
                                          : "Đã hủy",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 115,
                            left: 298,
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(
                                'assets/icons/delete.png',
                                width: 20,
                                height: 20,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFEFF0F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Địa chỉ giao hàng',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${order.state} ${order.city} ${order.locality}",
                          style: GoogleFonts.lato(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Đến: ${order.fullName}",
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Mã đơn hàng: ${order.id}",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                    onPressed: () async{
                      await orderController.updateDeliveryStatus(id: order.id, context: context);
                    },
                    child: Text(
                      "Đánh dấu đơn hàng đã được giao",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      await orderController.cancelOrder(id: order.id, context: context);
                    }
                    ,
                    child: Text(
                      "Huỷ",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
