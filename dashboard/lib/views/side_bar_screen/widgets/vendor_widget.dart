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
  late Future<List<Vendor>> futureVendors;

  @override
  void initState() {
    super.initState();
    futureVendors = VendorController().loadVendors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vendor>>(
      future: futureVendors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có người bán nào.'));
        } else {
          final vendors = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vendors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.green.shade400,
                          child: Text(
                            vendor.fullName[0].toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          vendor.fullName,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          vendor.email,
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${vendor.state}, ${vendor.city}",
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: Text(
                            "Xoá",
                            style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
