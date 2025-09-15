import 'package:dashboard_ecomerce/views/side_bar_screen/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'orderscreen';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề trang
          Text(
            "Quản lý đơn hàng",
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Bảng danh sách đơn hàng
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3C55EF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      _headerCell("Ảnh sản phẩm", flex: 2),
                      _headerCell("Tên sản phẩm", flex: 2),
                      _headerCell("Giá sản phẩm", flex: 2),
                      _headerCell("Danh mục", flex: 2),
                      _headerCell("Tên khách", flex: 2),
                      _headerCell("Email khách", flex: 2),
                      _headerCell("Địa chỉ khách", flex: 2),
                      _headerCell("Trạng thái", flex: 2),
                    ],
                  ),
                ),

                // Nội dung (list đơn hàng)
                const OrderWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Header cell styling
  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
