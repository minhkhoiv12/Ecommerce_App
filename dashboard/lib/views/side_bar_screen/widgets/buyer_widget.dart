import 'package:dashboard_ecomerce/controllers/buyer_controller.dart';
import 'package:dashboard_ecomerce/models/buyer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<BuyerWidget> {
  late Future<List<Buyer>> futureBuyers;

  @override
  void initState() {
    super.initState();
    futureBuyers = BuyerController().loadBuyers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Buyer>>(
      future: futureBuyers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có người mua nào.'));
        } else {
          final buyers = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: buyers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final buyer = buyers[index];
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
                        flex: 2,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.blue.shade200,
                          child: Text(
                            buyer.fullName[0].toUpperCase(),
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
                          buyer.fullName,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          buyer.email,
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${buyer.state}, ${buyer.city}",
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
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
