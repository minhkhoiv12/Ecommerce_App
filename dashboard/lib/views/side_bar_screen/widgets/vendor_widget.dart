import 'package:dashboard_ecomerce/controllers/vendor_controller.dart';
import 'package:dashboard_ecomerce/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  // A Future that will hold the list of buyers once loaded from api
  late Future<List<Vendor>> futureVendors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureVendors = VendorController().loadVendors();
  }

  @override
  Widget build(BuildContext context) {
    Widget buyerData(int flex, Widget widget) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Padding(padding: const EdgeInsets.all(8), child: widget),
        ),
      );
    }

    return FutureBuilder(
      future: futureVendors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có banner nào '));
        } else {
          final vendors = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: vendors.length,

            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    buyerData(
                      1,
                      CircleAvatar(
                        child: Text(
                          vendor.fullName[0],
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    buyerData(
                      3,
                      Text(
                        vendor.fullName,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    buyerData(
                      2,
                      Text(
                        vendor.email,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    buyerData(
                      2,
                      Text(
                        "${vendor.state} ${vendor.city}",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    buyerData(
                      1,
                      TextButton(onPressed: () {}, child: Text('Xoá')),
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
