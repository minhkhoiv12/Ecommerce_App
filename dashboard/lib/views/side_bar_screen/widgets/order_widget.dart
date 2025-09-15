import 'package:dashboard_ecomerce/controllers/order_controller.dart';
import 'package:dashboard_ecomerce/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = OrderController().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    Widget orderCell(int flex, Widget child, {TextAlign align = TextAlign.center}) {
      return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Align(alignment: Alignment.center, child: child),
        ),
      );
    }

    return FutureBuilder<List<Order>>(
      future: futureOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Lỗi: ${snapshot.error}",
              style: GoogleFonts.montserrat(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Không có đơn hàng nào',
                style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        } else {
          final orders = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    orderCell(
                      2,
                      Image.network(order.image, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    orderCell(
                      2,
                      Text(
                        order.productName,
                        style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    orderCell(
                      2,
                      Text(
                        "\$${order.productPrice.toStringAsFixed(2)}",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    orderCell(
                      2,
                      Text(order.category, style: GoogleFonts.montserrat(fontSize: 14)),
                    ),
                    orderCell(
                      2,
                      Text(order.fullName, style: GoogleFonts.montserrat(fontSize: 14)),
                    ),
                    orderCell(
                      2,
                      Text(order.email, style: GoogleFonts.montserrat(fontSize: 13)),
                    ),
                    orderCell(
                      2,
                      Text(order.locality, style: GoogleFonts.montserrat(fontSize: 13)),
                    ),
                    orderCell(
                      2,
                      Text(
                        order.delivered
                            ? "Đã giao"
                            : order.processing
                                ? "Đang xử lý"
                                : "Đã huỷ",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: order.delivered
                              ? Colors.green
                              : order.processing
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
