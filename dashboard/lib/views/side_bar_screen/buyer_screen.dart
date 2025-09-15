import 'package:dashboard_ecomerce/views/side_bar_screen/widgets/buyer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerScreen extends StatelessWidget {
  static const String id = '\buyerscreen';
  const BuyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _rowHeader(int flex, String text) {
      return Expanded(
        flex: flex,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          color: const Color(0xFF3C55EF),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quản lý người mua",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Header row
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  _rowHeader(2, 'Hình ảnh'),
                  _rowHeader(3, 'Tên đầy đủ'),
                  _rowHeader(3, 'Email'),
                  _rowHeader(3, 'Địa chỉ'),
                  _rowHeader(2, 'Thao tác'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const BuyerWidget(),
          ],
        ),
      ),
    );
  }
}
