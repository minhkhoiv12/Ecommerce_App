import 'package:bai1/controllers/auth_controller.dart';
import 'package:bai1/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  ConsumerState<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;
  // late String state;
  // late String city;
  // late String locality;
  @override
  void initState() {
    super.initState();
    //Read the current user data from the provider
    final user = ref.read(userProvider);
    //Initialize the text controllers with existing user data if available
    //If user data is not available, initialize with empty strings
    _stateController = TextEditingController(text: user?.state ?? "");
    _cityController = TextEditingController(text: user?.city ?? "");
    _localityController = TextEditingController(text: user?.locality ?? "");
  }
  //Show Loading Dialog
  _showLoadingDialog(){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20,),
                Text('Updating...',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
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
                 controller: _stateController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập Tỉnh hoặc thành phố";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tỉnh, thành phố',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _cityController,
                 
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập quận, huyện, thành phố trực thuộc";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Quận, huyện, thành phố trực thuộc',
                  ),
                ),
                 const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _localityController,
                 
                  validator: (value){
                    if(value!.isEmpty){
                      return "Vui lòng nhập phường, xã, thị trấn";
                    }
                    return null;
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
          onTap: () async{
       
            if(_formKey.currentState!.validate()){
              _showLoadingDialog();
              //print('data');
              await _authController.updateUserLocation(
                context: context, 
                id: user!.id, 
                state: _stateController.text, 
                city: _cityController.text, 
                locality: _localityController.text,
              ).whenComplete((){
                updateUser.recreateUserState(
                  state: _stateController.text, 
                  city: _cityController.text, 
                  locality: _localityController.text
                );
                Navigator.pop(context);// this will close the Dialog
                Navigator.pop(context);// this will close the ShippingAddressScreen it will take us back to the formal which is the checkout screen
              });
              
             // Navigator.pop(context);
          
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