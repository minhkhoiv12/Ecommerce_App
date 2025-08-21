 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAdressScreen extends StatefulWidget {
   const ShippingAdressScreen({super.key});
 
   @override
   State<ShippingAdressScreen> createState() => _ShippingAdressScreenState();
 }
 
 class _ShippingAdressScreenState extends State<ShippingAdressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white.withAlpha((0.96*255).round()),
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha((0.96*255).round()),
        title: Text(
          'Vận chuyển',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('đơn hàng của bạn\n sẽ được giao đến đâu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập Tỉnh hoặc thành phố";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tỉnh, thành phố',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập quận, huyện, thành phố trực thuộc";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Quận, huyện, thành phố trực thuộc',
                  ),
                ),
                 const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập phường, xã, thị trấn";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phường, xã, thị trấn',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(_formKey.currentState!.validate()){
              print('Valid');

            }
            else{
              print('Not valid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color:const Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text('Lưu',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
     );
   }
 }