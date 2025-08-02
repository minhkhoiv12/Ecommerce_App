
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor/controllers/vendor_auth_controller.dart';
import 'package:vendor/views/screens/authentication/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  // const RegisterScreen({super.key});
  @override
   State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _vendorAuthController = VendorAuthController();
  late String email;
  late String fullName;
  late String password;
  bool isLoading = false;
  registerUser() async {
      setState(() {
        isLoading = true;
      });
      await _vendorAuthController.signUpVendor(
        context: context,
        email: email,
        fullName: fullName,
        password: password,
      ).whenComplete(() {
        _formKey.currentState!.reset(); // Reset the form after successful registration
        // This will be called when the sign-in process is complete
        // You can navigate to another screen or show a success message here
        setState(() {
        isLoading = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha((0.95 * 255).round()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Đăng ký tài khoản",
                style:GoogleFonts.getFont(
                  'Lato',
                  color: Color(0xFF0d120E),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                  fontSize: 23,
                  )
                ),
                Text("Khám phá những sản phẩm mới nhất",
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                    fontSize: 14,
                  )
                ),
                Image.asset('assets/images/Illustration.png',
                  width: 200,
                  height: 200,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng diền email của bạn';
                    }
                    // Simple email validation
                    else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Vui lòng nhập email',
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/email.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                 Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Full Name',
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng diền tên đầy đủ của bạn';
                    }
                    else
                    {
                      return null;
                    }
                    
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Nhập tên đầy đủ của bạn',
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/user.jpeg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Vui lòng diền mật khẩu của bạn';
                    }
                    else if(value.length < 6)
                    {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Vui lòng nhập mật khẩu',
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/password.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    suffixIcon: Icon(Icons.visibility),
            
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                    
                  },
                  child: Container(
                    width: 319,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF102DE1),
                          Color(0xCC0D6EFF),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 278,
                          top: 19,
                          child: Opacity(opacity: 0.5, 
                            child: Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF103DE5),
                                  width: 12,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            
                            ),
                          ),
                        ),
                        Positioned(
                          left: 260,
                          top: 29,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              width: 10,
                              height: 10,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 311,
                          top: 36,
                          child: Opacity(
                            opacity: 0.3,
                            child: Container(
                              width: 5,
                              height: 5,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                color: Color(0xFF103DE5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            
                          ),
                        ),
                         Positioned(
                          left: 281,
                          top: -10,
                          child: Opacity(
                            opacity: 0.3,
                            child: Container(
                              width: 20,
                              height: 20,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Center(child: isLoading?const CircularProgressIndicator(color: Colors.white,): Text("Sign Up",
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )
                           ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                      ),
                    ),
                    InkWell(
                       onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      },
                      child: Text('Sign In',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                            color: Color(0xFF102DE1),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 